(function() {
  var services;

  services = angular.module('hackboardServices', []);

  services.factory('User', [
    '$http', function($http) {
      return {
        login: function(email, password) {
          return $http.post('/api/user/login', {
            email: email,
            password: password
          });
        },
        logout: function() {},
        signUp: function(email, nickName, password, passwordConfirmation) {
          return $http.post('/api/user/register', {
            email: email,
            name: nickName,
            password: password,
            password_confirmation: passwordConfirmation
          });
        }
      };
    }
  ]);

  services.factory('Board', [
    '$http', function($http) {
      return {
        create: function() {
          return $http.post('/api/boards/');
        },
        boards: function() {
          return $http.get('/api/boards/');
        },
        pin: function(id) {
          return $http.post('/api/user/pinboard', {
            board_id: id
          });
        },
        unpin: function(id) {
          return $http.post('/api/user/unpinboard', {
            board_id: id
          });
        }
      };
    }
  ]);

}).call(this);
