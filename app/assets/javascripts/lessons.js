$(document).ready(function(){
	$('.timepicker').timepicker()
	
	$('#teachers_select').change(function(){
		$.ajax({
	    	url: "/update_instruments",
	        data: {
	          teacher_id : $('#teachers_select').val()
	        },
	        type: "GET",
			success: function(result)
			{
				$('#lesson_instrument_id').html(result).show();
			}
	   	});
	 });
});

