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
    agree: ''
    hasError: false
    hasWarning: false

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

  return
]