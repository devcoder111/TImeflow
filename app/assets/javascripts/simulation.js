// later when need to monitor status
$(function() {
  var $statusElm = $("div.simulation-status");
  console.log($statusElm);
  $("button#start").on("click", function(e) {
    e.preventDefault();
  });
});