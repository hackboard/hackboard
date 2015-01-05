hackboard = angular.module 'hackboardApp', [
  'ng-rails-csrf',
  'yaru22.angular-timeago',
  'angularify.semantic.checkbox',
  'ui.sortable',
  'hackboardControllers',
  'hackboardServices',
  'hackboardDirective'
]

angular.module('hackboardDirective', [])
.directive('semanticPopup', ()->
  (scope, element, attrs)->
    $(element).popup({
        position: 'top right',
        transition: 'fade',
        className: {
          popup: 'ignored ui popup'
        },
        on: 'click'
      }
    )
)

.directive('boardPeoplePopup', ()->
  (scope, element, attrs)->
    $(element).popup({
        position: 'top right',
        transition: 'fade',
        className: {
          popup: 'ignored ui popup'
        }
      }
    )
)
.directive('hackboardCalculateListWidth', ()->
  (scope, element, attrs)->
    $(".ui-list-wrapper").each (index, value)->
      count = $(this).find(".ui-list-subflow").length
      $(this).width(311 * count)
#      $(this).width(306 * count)
)
.directive('baordFlowEditButton', ()->
  (scope, element, attrs)->
    $(element).click ()->
      flip_parent = $(element).closest(".ui-flip")
      flip(flip_parent)
      fade_parent = $(element).closest(".ui-toggle")
      toggle(fade_parent)
)
