$(document).ready(function(){

  $('[data-toggle="slide-collapse"]').on('click', function() {
    $navMenuCont = $($(this).data('target'));
    $navMenuCont.animate({
      'width': 'toggle'
    }, 350);
    $(".menu-overlay").fadeIn(500);

  });

  $(".menu-overlay").click(function(event) {
    $(".navbar-toggle").trigger("click");
    $(".menu-overlay").fadeOut(500);
  });
  $("form").on("click", ".remove_fields", function (event) {
    $(this).prev("input[type=hidden]").val("1");
    $(this).closest("fieldset").hide();
    return event.preventDefault();
  });
  $("form").on("click", ".add_fields", function (event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
    return event.preventDefault();
  });

});

