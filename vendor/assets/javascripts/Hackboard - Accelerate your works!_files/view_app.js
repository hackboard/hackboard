(function() {
  var hackboard;

  hackboard = angular.module('hackboardApp', ['ng-rails-csrf', 'yaru22.angular-timeago', 'angularify.semantic.checkbox', 'ui.sortable', 'hackboardControllers', 'hackboardServices', 'hackboardDirective']);

  angular.module('hackboardDirective', []).directive('semanticPopup', function() {
    return function(scope, element, attrs) {
      return $(element).popup({
        position: 'top right',
        transition: 'fade',
        className: {
          popup: 'ignored ui popup'
        },
        on: 'click'
      });
    };
  });

}).call(this);
