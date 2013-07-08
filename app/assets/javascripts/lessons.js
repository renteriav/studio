$(document).ready(function(){
	$('.timepicker').timepicker()
	
	$('#instrument_select').change(function(){
		$.ajax({
	    	url: "/update_teachers",
	        data: {
	          instrument_id : $('#instrument_select').val()
	        },
	        type: "GET",
			success: function(result)
			{
				$('#lesson_teacher_id').html(result).show();
			}
	   	});
	 });
});

