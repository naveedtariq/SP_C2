user_tool_tips={}

$(document).ready(function() {
	// Find a Ride Description Tooltip
	$(".HelpTooltip[title]").tooltip({
		tipClass: "SimpleTooltip",
		effect: 'fade'
	});


  $.each(user_tool_tips, function(key, value) {
    $(key).tooltip({
      tip: value,
      predelay: 250,
      delay: 250,
      effect: 'fade',
      relative: true
    });
  });
	
});