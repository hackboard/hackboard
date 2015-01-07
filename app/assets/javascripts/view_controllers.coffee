controllers = angular.module 'hackboardControllers', []

# Login, Register Controller
controllers.controller 'UserCtrl', ['$scope', 'User', '$window', ($scope, User, $window)->
# 紀錄登入資訊的 Model
  $scope.loginInfo =
    email: "Alice@meigic.tw"
    password: "12345678"
    rememberMe: false
    hasError: false
    hasWarning: false

  # 註冊資訊的Model
  $scope.registerInfo =
    email: ''
    nickname: ''
    password: ''
    password_confirmation: ''
    agree: false
    hasError: false
    hasWarning: false
    warning_message: ''
    nicknameDirty: false

  $scope.$watch('registerInfo.email', (old, newv)->
    $scope.registerInfo.avatar = md5($scope.registerInfo.email)
  )

  # 登入按鈕按下時要做的動作
  $scope.btnLogin = ()->
    # reset message
    $scope.loginInfo.hasError = false
    $scope.loginInfo.hasWarning = false

    User.login(
      $scope.loginInfo.email
      $scope.loginInfo.password
      $scope.loginInfo.rememberMe
    )
    .success((data, status)->
      $window.location.href = '/boards'
      return
    )
    .error((data, status)->
      if data == "UMSE01" or data == "UMSE02"
        $scope.loginInfo.hasWarning = true
      else
        $scope.loginInfo.hasError = true
      return
    )
    return

  # 從登入轉到註冊卡片，並帶入資料
  $scope.btnRegister = ()->
    $scope.registerInfo.email = $scope.loginInfo.email
    resetAllError()
    switchCard $("#loginCard"), $("#signupCard")

  resetAllError = ()->
    $scope.loginInfo.hasError = $scope.loginInfo.hasWarning = $scope.registerInfo.hasError = $scope.registerInfo.hasWarning = false
    return

  resetSignUpAllError = ()->
    $scope.registerInfo.hasError = $scope.registerInfo.hasWarning = false
    $scope.registerInfo.warning_message = ''
    return

  cleanUpSignUpInformations = ()->
    $scope.registerInfo.email = $scope.registerInfo.nickname = $scope.registerInfo.password = $scope.registerInfo.password_confirmation = ''
    $scope.registerInfo.agree = false
    return

  #按下註冊鈕
  $scope.btnSignUp = ()->
    #Reset
    $scope.registerInfo.hasError = false
    $scope.registerInfo.hasWarning = false
    $scope.registerInfo.warning_message = ''

    #Check e-mail pattern
    if $scope.signUpForm.signUpEmail.$error.pattern
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your E-Mail does not match the pattern.It Should be abc@efg.com.'
      return
    #Check shortname is match pattern
    if $scope.signUpForm.nickName.$error.required or $scope.signUpForm.nickName.$error.pattern
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your short name dose not match the pattern. May content illegal character.'
      return
    #Check password and passwordConfirmation at least 8 character
    if $scope.signUpForm.password.$error.minlength or $scope.signUpForm.password_confirmation.$error.minlength
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your password needs at least 8 characters.'
      return
    #Check password and passwordConfirmation match pattern
    if $scope.signUpForm.password.$error.pattern or $scope.signUpForm.password_confirmation.$error.pattern
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your password does not match the pattern. May content illegal character.'
      return
    #Check password and passwordConfirmation are same...
    if $scope.registerInfo.password != $scope.registerInfo.password_confirmation
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Passwords are not the same.'
      return
    #Check agree checkbox is checked
    if $scope.registerInfo.agree == false
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'You need to agree Term of Service.'
      return

    #Sign up...
    User.signUp(
      $scope.registerInfo.email,
      $scope.registerInfo.nickname,
      $scope.registerInfo.password,
      $scope.registerInfo.password_confirmation
    )
    .success((data, status)->
      $scope.loginInfo.email = $scope.registerInfo.email
      $scope.loginInfo.password = ''
      #clean up ...
      cleanUpSignUpInformations()
      resetSignUpAllError()
      #Flip to login scene
      switchCard $('#signupCard'), $('#loginCard')
    )
    .error((data, status)->
      if data == "UMSE03"
        $scope.registerInfo.hasWarning = true
        $scope.registerInfo.warning_message = 'Account already exist.'
        return
      else if data == "UMSE04"
        $scope.registerInfo.hasWarning = true
        $scope.registerInfo.warning_message = 'Passwords dose not the same.'
        return
      else
        $scope.registerInfo.hasError = true
    )
    return

  #Change shortname when email been done (Cannot change when type in email account)
  $scope.putToNickname = ()->
    if !$scope.signUpForm.signUpEmail.$error.pattern
      $scope.registerInfo.nickname = $scope.registerInfo.email.split("@")[0]
    return

  return
]

# Boards Page
controllers.controller 'BoardsCtrl', ['$scope', 'User', 'Board', '$window', 'timeAgo', '$http',
  ($scope, User, Board, $window, timeAgo, $http)->
    $scope.boards = {
      pin: [],
      other: []
    }

    $http.get('/api/user/current_user').success((data, status)->
      $scope.current_user = data
      $scope.current_user.avatar = md5(data.email)
    )

    # async load boards data
    Board.boards().success((data, status)->
      $scope.boards = data
    )

    # sortable setting
    $scope.pinBoardSortOptions = {
      containment: '#pinned-boards',
      additionalPlaceholderClass: 'ui column',
      accept: (sourceItemHandleScope, destSortableScope)->
        sourceItemHandleScope.itemScope.sortableScope.$id == destSortableScope.$id
    }

    $scope.otherBoardSortOptions = {
      containment: '#other-boards',
      additionalPlaceholderClass: 'ui column',
      accept: (sourceItemHandleScope, destSortableScope)->
        sourceItemHandleScope.itemScope.sortableScope.$id == destSortableScope.$id
    }

    # processing pin and unpin

    $scope.pin = (id)->
      angular.forEach $scope.boards.other, (value, key)->
        if value.id == id
          $scope.boards.pin.push $scope.boards.other[key]
          $scope.boards.other.splice key, 1
          Board.pin(id)
      return

    $scope.unpin = (id)->
      angular.forEach $scope.boards.pin, (value, key)->
        if value.id == id
          $scope.boards.other.push $scope.boards.pin[key]
          $scope.boards.pin.splice key, 1
          Board.unpin(id)
      return

    # new board
    $scope.newBoard = ()->
      Board.create().success((data, status)->
#      $scope.boards.other.push data.board
        $window.location.href = '/board/' + data.board.id
      )
      return

    # click card to board
    $scope.toBoard = (id)->
      $window.location.href = '/board/' + id
]

# board Page
controllers.controller 'BoardCtrl', ['$scope', '$window', 'Board', '$http', ($scope, $window, Board, $http)->
  board_id = parseInt($window.location.pathname.split('/')[2])
  $scope.board = [
    flows: []
  ]
  $scope.current_user = {}

  $scope.getlabelname = (shortname) ->
    return  unless shortname
    name = shortname.split(/[\s,]+/)
    if name.length is 1
      name = name[0].slice(0, 2).toUpperCase()
      return name
    else
      i = 0
      while i < name.length
        name[i] = name[i].slice(0, 1)
        i++
      return name.join("").slice(0, 2).toUpperCase()

  #  # flow sortable setting
  $scope.flowSortOptions = {
    containment: '#board-content',
    additionalPlaceholderClass: 'ui-list-placeholder',
    accept: (sourceItemHandleScope, destSortableScope)->
      sourceItemHandleScope.itemScope.sortableScope.$id == destSortableScope.$id
    orderChanged: (obj)->
      flowOrder = []
      for key of $scope.board.flows
        flowOrder.push $scope.board.flows[key].id
      $http.post('/api/flows/updateorder' , {
        data: flowOrder
      })
      return

  }

  $scope.taskSortOptions = {
#    containment: '#board-content',
#    additionalPlaceholderClass: 'ui grid ui-board-content',
    accept: (sourceItemHandleScope, destSortableScope)->
      if sourceItemHandleScope.itemScope.hasOwnProperty('flow')
        return false
      true
    orderChanged: (obj)->
      taskOrder = []
      for key of obj.dest.sortableScope.modelValue
        taskOrder.push obj.dest.sortableScope.modelValue[key].id
      $http.post('/api/boards/' + $scope.board.id + '/updatetaskorder' , {
        data: taskOrder
      })
      return
    itemMoved: (obj)->
      console.log obj

      task = obj.source.itemScope.task

      oldFlowID = task.flow_id
      newFlowID = null

      for key of $scope.board.flows
        for key2 of $scope.board.flows[key].tasks
          if $scope.board.flows[key].tasks[key2].id == task.id
            newFlowID = $scope.board.flows[key].id
            $scope.board.flows[key].tasks[key2].flow_id =newFlowID


      taskOrder = []
      for key of obj.dest.sortableScope.modelValue
        taskOrder.push obj.dest.sortableScope.modelValue[key].id

      $http.post('/api/boards/' + $scope.board.id + '/task/move' , {
        taskId:obj.source.itemScope.modelValue.id
        sFlow: oldFlowID
        dFlow: newFlowID
        order: taskOrder
      } )

  }

  Board.board(board_id).success((data, status)->
    $scope.board = data

    Board.flows($scope.board.id).success((data, status)->
      $scope.board.flows = data

#      $scope.$watch('board', ((old, nv)->
#        $http.post('/api/update', {
#          board: $scope.board
#        })
#      ), true)
    )
  ).error((data, status)->
    $window.location.href = "/boards"
  )

  $http.get('/api/user/current_user').success((data, status)->
    $scope.current_user = data
    $scope.current_user.avatar = md5(data.email)
    $scope.current_user.shortname = $scope.getlabelname(data.name)
    $scope.$watch('current_user.name', (oldValue, newValue)->
      $scope.current_user.shortname = $scope.getlabelname($scope.current_user.name)
      if oldValue != newValue
        $http.post('/api/user/' + $scope.current_user.id + '/save' , {
          name: $scope.current_user.name
        })
      return
    )
  )
#
  $scope.titleClick = (id)->
    $('#board-detail-modal').modal({
      transition: 'slide down',
      duration: '100ms',
      onVisible: ()->
        $(window).resize()
        return
    }).modal('show')
    return

  $scope.taskClick = (id)->
    angular.forEach($scope.board.flows , (value , key)->
      angular.forEach(value.tasks , (task,key)->
        if task.id == id
          $scope.taskData = task
        return
      )
      angular.forEach(value.flows , (subflow , key)->
        angular.forEach(subflow.tasks , (task,  key)->
          if task.id == id
            $scope.taskData = task
          return
        )
        return
      )
      return
    )

    $('#task-detail-modal').modal({
      transition: 'slide down',
      duration: '100ms',
      onVisible: ()->
        $(window).resize()
        return
    }).modal('show')
    return

  $scope.removeBoardMember = (id)->
    angular.forEach($scope.board.users, (value, key)->
      if value.id == id
        $http.post('/api/baords/' + $scope.board.id + '/users/delete/' + value.id)
        $scope.board.users.splice key, 1
    )
    return

  $scope.newFlow = ()->
    $http.post('/api/boards/' + $scope.board.id + '/flows/add').success((data, status)->
      $scope.board.flows.push data
    )
    return

  $scope.newTask = (id)->
    $http.post('/api/boards/' + $scope.board.id + '/flows/' + id + '/task/add').success(
      (data, status)->
        angular.forEach($scope.board.flows, (flow, key)->
          angular.forEach(flow.flows, (subFlow, key2)->
            if subFlow.id == id
              subFlow.tasks.push data
          )
          if flow.id == id
            flow.tasks.push data
        )
    )
    return

  $scope.selpeople = ""

  $scope.addmember = ()->
    $http.post('/api/boards/' + $scope.board.id + '/users/add/' + $scope.selpeople).success(
      (data, status)->
        $scope.board.users.push(data)
        $scope.selpeople = ""
    ).error(()->
      $scope.selpeople = ""
    )

  $scope.people = [
    {"id": 2, "email": "alice@meigic.tw", "name": "Alice"},
    {"id": 5, "email": "a60814billy@gmail.com", "name": "a60814billy"}
  ]

  $scope.findPeople = (name)->
    $http.get('/api/user/find/' + name)


  hbSocket = io.connect 'http://www.meigic.tw:33555'
  hbSocket.on 'hb' , (message)->
#    console.log message
    if message.board_id == $scope.board.id
      switch message.type
        when "flowOrderChange"
          processFlowOrderChange(message.order)
        when "taskOrderChange"
          processTaskOrderChange(message.flow_id , message.order)
        when "taskMove"
          processTaskMove(message.task_id , message.sFlow , message.dFlow , message.order)
        else
          console.log message
    return

  processTaskMove = (taskid , oldFlowID , newFlowID , order)->
    console.log "processTaskMove"
    for key of $scope.board.flows
      if $scope.board.flows[key].id == oldFlowID
        findInOldFlow = null
        for k2 of $scope.board.flows[key].tasks
          if $scope.board.flows[key].tasks[k2].id == taskid
            console.log $scope.board.flows[key].tasks[k2]
            findInOldFlow = $scope.board.flows[key].tasks[k2]
            for k3 of $scope.board.flows
              if $scope.board.flows[k3].id == newFlowID
                $scope.board.flows[k3].tasks.push findInOldFlow
                $scope.board.flows[key].tasks.splice k2 , 1
                break
            processTaskOrderChange(newFlowID , order)
            break

    return

  processFlowOrderChange = (newOrder)->
    console.log "processFlowOrderChange"
    dirty = false
    for key of $scope.board.flows
      if $scope.board.flows[key].id != newOrder[key]
        dirty = true
        break
    if dirty
      newOrderFlows = []
      for flowID of newOrder
        for key of $scope.board.flows
          if $scope.board.flows[key].id == newOrder[flowID]
            newOrderFlows.push $scope.board.flows[key]
            break
      $scope.board.flows = newOrderFlows
    return

  processTaskOrderChange = ( flow_id ,  newOrder)->
    console.log "processTaskOrderChange" , flow_id , newOrder
    targetFlow = null
    for key of $scope.board.flows
      if $scope.board.flows[key].id == flow_id
        targetFlow = $scope.board.flows[key]
        break

    dirty = false
    if targetFlow
      for key of targetFlow.tasks
        if targetFlow.tasks[key].id != newOrder[key]
          dirty = true
          break

      if dirty
        newOrderTasks = []
        for taskKey of newOrder
          for key of targetFlow.tasks
            if targetFlow.tasks[key].id == newOrder[taskKey]
              newOrderTasks.push targetFlow.tasks[key]
              break

        targetFlow.tasks = newOrderTasks
    return

]