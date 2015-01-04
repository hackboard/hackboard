hackboard = angular.module 'hackboardApp', [
  'ng-rails-csrf',
  'yaru22.angular-timeago',
  'angularify.semantic.checkbox',
  'ui.sortable',
  'hackboardControllers',
  'hackboardServices',
  'hackboardDirective'
]

angular.module('hackboardDirective',[])
  .directive 'semanticPopup' , ()->
    (scope,element,attrs)->
      $(element).popup({
        position: 'top right',
        transition: 'fade',
        className: {
          popup: 'ignored ui popup'
        },
        on: 'click'
      })