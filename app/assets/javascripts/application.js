//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require private_pub
//= require_tree .
//= require bootstrap-datepicker
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js

$(document).ready(function(){
  $('.datepicker').datepicker({
    format: "dd/mm/yyyy",
    endDate: 0,
    maxViewMode: 2,
    todayBtn: "linked"
  });
});
