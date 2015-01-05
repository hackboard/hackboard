services = angular.module 'hackboardServices' , []

# 處理登入、登出、註冊的Service
services.factory 'User' , ['$http' , ($http)->
  login:(email , password)->
    $http.post(
      '/api/user/login',
        email: email,
        password: password
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

  board: (id)->
    $http.get '/api/boards/' + id

  flows: (board_id)->
    $http.get '/api/boards/' + board_id + '/flows'

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

services.factory 'Flow' , ['$http' , ($http)->

  flow: (board_id)->
    $http.get '/api/flows/' + board_id

]