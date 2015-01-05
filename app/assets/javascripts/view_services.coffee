services = angular.module 'hackboardServices' , []

# 處理登入、登出、註冊的Service
services.factory 'User' , ['$http' , ($http)->
  login:(email , password, rememberMe)->
    $http.post(
      '/api/user/login',
        email: email,
        password: password,
        remember_me: rememberMe
    )
  logout: ()->
    return
  signUp: (email,nickName,password,passwordConfirmation)->
    #Authenticity Token?
    $http.post(
      '/api/user/register',
      email:email,
      name:nickName,
      password:password,
      password_confirmation:passwordConfirmation
    )
]

services.factory 'Board' , ['$http' , ($http)->
  create: ()->
    $http.post '/api/boards/'

  boards: ()->
    $http.get '/api/boards/'

  pin: (id)->
    $http.post(
      '/api/user/pinboard',
      board_id: id
    )

  unpin: (id)->
    $http.post(
      '/api/user/unpinboard',
      board_id: id
    )
]