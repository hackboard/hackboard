hackboard = angular.module 'hackboardApp', [
  'ng-rails-csrf',
  'yaru22.angular-timeago',
  'angularify.semantic.checkbox',
  'ui.sortable',
  'ui.select',
  'ngSanitize',
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
.directive('contenteditable', ()->
  require: "ngModel",
  restrict: "A",
  link: (scope, element, attrs, ngModel)->
    read = ()->
      ngModel.$setViewValue(element.text())
      return
    ngModel.$render = ()->
      element.text(ngModel.$viewValue || "")
      return
    element.bind "blur keyup change", ()->
      scope.$apply(read);
      return
    element.bind "mousedown", (event)->
      event.stopPropagation()
      return
    element.bind "keydown", (event)->
      # trap the return key being pressed
      if event.keyCode is 13 && $(element).css("white-space") == "nowrap"
        event.stopPropagation()
        event.preventDefault()
        # insert 2 br tags (if only one br tag is inserted the cursor won't go to the next line)
        #document.execCommand "insertHTML", false, "<br><br>"
        # prevent the default behaviour of return key pressed
        false
    return
)
