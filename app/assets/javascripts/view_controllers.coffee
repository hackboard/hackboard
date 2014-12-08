controllers = angular.module 'hackboardControllers', []

# Login, Register Controller
controllers.controller 'UserCtrl', ['$scope', 'User', '$window', ($scope, User , $window)->
# 紀錄登入資訊的 Model
  $scope.loginInfo =
    email: "Alice@meigic.tw"
    password: "Alice0000"
    rememberMe: ""
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

  # 登入按鈕按下時要做的動作
  $scope.btnLogin = ()->
    # reset message
    $scope.loginInfo.hasError = false
    $scope.loginInfo.hasWarning = false

    User.login(
      $scope.loginInfo.email
      $scope.loginInfo.password
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

    #Check shortname is at least 8 character
    if $scope.signUpForm.nickName.$error.minlength
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your short name need at least 8 characters.'
      return
    #Check shortname is match pattern
    if $scope.signUpForm.nickName.$error.required or $scope.signUpForm.nickName.$error.pattern
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your short name dose not match the pattern. '
      return
    #Check password and passwordConfirmation at least 8 character
    if $scope.signUpForm.password.$error.minlength or $scope.signUpForm.password_confirmation.$error.minlength
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your password needs at least 8 characters.'
      return
    #Check password and passwordConfirmation match pattern
    if $scope.signUpForm.password.$error.pattern or $scope.signUpForm.password_confirmation.$error.pattern
      $scope.registerInfo.hasWarning = true
      $scope.registerInfo.warning_message = 'Your password does not match the pattern.'
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
    .success((data,status)->
      $scope.loginInfo.email = $scope.registerInfo.email
      $scope.loginInfo.password = ''
      #clean up ...
      cleanUpSignUpInformations()
      resetSignUpAllError()
      #Flip to login scene
      switchCard $('#signupCard'),$('#loginCard')
    )
    .error((data,status)->
      if data == "UMSE03"
        $scope.registerInfo.hasWarning = true
        $scope.registerInfo.warning_message = 'Account already exist.'
        return
      else if data == "UMSE04"
        $scope.registerInfo.hasWarning = true
        $scope.registerInfo.warning_message  = 'Passwords dose not the same.'
        return
      else
        $scope.registerInfo.hasError = true
    )
    return

  return
]