services = angular.module 'hackboardServices' , []

# 處理登入、登出、註冊的Service
services.factory 'User' , ['$http' , ($http)->
  login:(email , password)->
    $http.post(
      '/user/login',
        email: email,
        password: password
    )
  logout: ()->
    return
  register: ()->
    return
]