//= require rails-ujs
//= require jquery3
//= require jquery-ui/widgets/datepicker
//= require jquery_ujs
//= require datepicker
//= require popper
//= require jquery.easing
//= require bootstrap
//= require_tree .

$(function () {
  setDatePicker();

  $('#menu-icon').click(function () {
    $('.topnav').toggleClass('topnav-opened');
  });
});
