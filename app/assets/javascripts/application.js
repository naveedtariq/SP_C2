// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
  $(".duration-change").change(function(){
    $("#div-estimated-arrival-time").show();
    departure_minutes = parseInt($("#ride_departure_time_5i").val());
    duration_minutes = parseInt($("#ride_duration_minutes").val());
    departure_hours = parseInt($("#ride_departure_time_4i").val());
    duration_hours = parseInt($("#ride_duration_hours").val());
    end_minutes = departure_minutes + duration_minutes;
    end_hours = (departure_hours + duration_hours + (parseInt(end_minutes/60)))%24;
    end_minutes = end_minutes % 60
    $("#estimated-arrival-time").text(end_hours + ":" + end_minutes);
  });
});