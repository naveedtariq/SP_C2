$(document).ready(function() {
	$('.chzn-select').chosen();
	
	$('.toggle-next').next().hide();
	$('.toggle-next').click(function() {
		$(this).next().slideToggle();
	});
	
	$('.triger_section li').click(function(){
		$('.pay_creditcard').css('display','none');
		$active = $(this).attr('id');
		$('#'+$active+'-tab').css('display','block');
		$('.triger_section li').removeClass('active');
		$(this).addClass('active');
	});
	
	
	$('#twowaytrip_edit').click(function(){
		if( $('#twowaytrip_edit').is(':checked') ) 
		{
			disabletwowaytrip();
		}
		else
		{			
			enabletwowaytrip();
		}
	});
	
	selectride();
	
	$('.LocationSwitch').click(function(){
		$left = $('#ridefrom').html();
		$right = $('#rideto').html();
		$swap = $left;
		$left = $right;
		$right = $swap;
		$('#ridefrom').html($left);
		$('#rideto').html($right);
	});
	
	
});

function selectride()
{
	
	$('.selectride').click(function(){
		$('.selectride').css('opacity','0.4');
		$(this).css('opacity','1');		
	});
}



function disabletwowaytrip()
{
	$('#twowaytrip_details').css('opacity','0.5');
	$('#twowaytrip_details :input').attr('disabled', true);
	
}


function enabletwowaytrip()
{
	$('#twowaytrip_details').css('opacity','1');	
	$('#twowaytrip_details :input').removeAttr('disabled');
	
}














	