(function() {
  var controllers;

  controllers = angular.module('hackboardControllers', []);

  controllers.controller('UserCtrl', [
    '$scope', 'User', '$window', function($scope, User, $window) {
      var cleanUpSignUpInformations, resetAllError, resetSignUpAllError;
      $scope.loginInfo = {
        email: "Alice@meigic.tw",
        password: "Alice0000",
        rememberMe: "",
        hasError: false,
        hasWarning: false
      };
      $scope.registerInfo = {
        email: '',
        nickname: '',
        password: '',
        password_confirmation: '',
        agree: false,
        hasError: false,
        hasWarning: false,
        warning_message: '',
        nicknameDirty: false
      };
      $scope.btnLogin = function() {
        $scope.loginInfo.hasError = false;
        $scope.loginInfo.hasWarning = false;
        User.login($scope.loginInfo.email, $scope.loginInfo.password).success(function(data, status) {
          $window.location.href = '/boards';
        }).error(function(data, status) {
          if (data === "UMSE01" || data === "UMSE02") {
            $scope.loginInfo.hasWarning = true;
          } else {
            $scope.loginInfo.hasError = true;
          }
        });
      };
      $scope.btnRegister = function() {
        $scope.registerInfo.email = $scope.loginInfo.email;
        resetAllError();
        return switchCard($("#loginCard"), $("#signupCard"));
      };
      resetAllError = function() {
        $scope.loginInfo.hasError = $scope.loginInfo.hasWarning = $scope.registerInfo.hasError = $scope.registerInfo.hasWarning = false;
      };
      resetSignUpAllError = function() {
        $scope.registerInfo.hasError = $scope.registerInfo.hasWarning = false;
        $scope.registerInfo.warning_message = '';
      };
      cleanUpSignUpInformations = function() {
        $scope.registerInfo.email = $scope.registerInfo.nickname = $scope.registerInfo.password = $scope.registerInfo.password_confirmation = '';
        $scope.registerInfo.agree = false;
      };
      $scope.btnSignUp = function() {
        $scope.registerInfo.hasError = false;
        $scope.registerInfo.hasWarning = false;
        $scope.registerInfo.warning_message = '';
        if ($scope.signUpForm.nickName.$error.required || $scope.signUpForm.nickName.$error.pattern) {
          $scope.registerInfo.hasWarning = true;
          $scope.registerInfo.warning_message = 'Your short name dose not match the pattern. ';
          return;
        }
        if ($scope.signUpForm.password.$error.minlength || $scope.signUpForm.password_confirmation.$error.minlength) {
          $scope.registerInfo.hasWarning = true;
          $scope.registerInfo.warning_message = 'Your password needs at least 8 characters.';
          return;
        }
        if ($scope.signUpForm.password.$error.pattern || $scope.signUpForm.password_confirmation.$error.pattern) {
          $scope.registerInfo.hasWarning = true;
          $scope.registerInfo.warning_message = 'Your password does not match the pattern.';
          return;
        }
        if ($scope.registerInfo.password !== $scope.registerInfo.password_confirmation) {
          $scope.registerInfo.hasWarning = true;
          $scope.registerInfo.warning_message = 'Passwords are not the same.';
          return;
        }
        if ($scope.registerInfo.agree === false) {
          $scope.registerInfo.hasWarning = true;
          $scope.registerInfo.warning_message = 'You need to agree Term of Service.';
          return;
        }
        User.signUp($scope.registerInfo.email, $scope.registerInfo.nickname, $scope.registerInfo.password, $scope.registerInfo.password_confirmation).success(function(data, status) {
          $scope.loginInfo.email = $scope.registerInfo.email;
          $scope.loginInfo.password = '';
          cleanUpSignUpInformations();
          resetSignUpAllError();
          return switchCard($('#signupCard'), $('#loginCard'));
        }).error(function(data, status) {
          if (data === "UMSE03") {
            $scope.registerInfo.hasWarning = true;
            $scope.registerInfo.warning_message = 'Account already exist.';
          } else if (data === "UMSE04") {
            $scope.registerInfo.hasWarning = true;
            $scope.registerInfo.warning_message = 'Passwords dose not the same.';
          } else {
            return $scope.registerInfo.hasError = true;
          }
        });
      };
      $scope.putToNickname = function() {
        if (!$scope.signUpForm.signUpEmail.$error.pattern) {
          $scope.registerInfo.nickname = $scope.registerInfo.email.split("@")[0];
        }
      };
    }
  ]);

  controllers.controller('BoardsCtrl', [
    '$scope', 'User', 'Board', '$window', function($scope, User, Board, $window, timeAgo) {
      $scope.boards = {
        pin: [],
        other: []
      };
      Board.boards().success(function(data, status) {
        return $scope.boards = data;
      });
      $scope.pinBoardSortOptions = {
        containment: '#pinned-boards',
        additionalPlaceholderClass: 'ui column',
        accept: function(sourceItemHandleScope, destSortableScope) {
          return sourceItemHandleScope.itemScope.sortableScope.$id === destSortableScope.$id;
        }
      };
      $scope.otherBoardSortOptions = {
        containment: '#other-boards',
        additionalPlaceholderClass: 'ui column',
        accept: function(sourceItemHandleScope, destSortableScope) {
          return sourceItemHandleScope.itemScope.sortableScope.$id === destSortableScope.$id;
        }
      };
      $scope.pin = function(id) {
        angular.forEach($scope.boards.other, function(value, key) {
          if (value.id === id) {
            $scope.boards.pin.push($scope.boards.other[key]);
            $scope.boards.other.splice(key, 1);
            return Board.pin(id);
          }
        });
      };
      $scope.unpin = function(id) {
        angular.forEach($scope.boards.pin, function(value, key) {
          if (value.id === id) {
            $scope.boards.other.push($scope.boards.pin[key]);
            $scope.boards.pin.splice(key, 1);
            return Board.unpin(id);
          }
        });
      };
      $scope.newBoard = function() {
        Board.create().success(function(data, status) {
          $scope.boards.other.push(data.board);
          return $window.location.href = '/board/' + data.board.id;
        });
      };
      return $scope.toBoard = function(id) {
        return $window.location.href = '/board/' + id;
      };
    }
  ]);

}).call(this);
