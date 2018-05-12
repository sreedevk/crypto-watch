// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function navbarToggle(){
  $("#nav-toggle").click(function(){
    $('.sidebar').toggleClass("active-sidebar");
    $('.main-panel').toggleClass("active-main");
  });
}

//$(document).ready(function(){
//  navbarToggle();
//});

$(document).on('turbolinks:load', function(){
  navbarToggle();
});
