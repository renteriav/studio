$(document).ready(function(){
	$('#timepicker_start').timepicker('setTime', gon.start_time);

	$('#timepicker_end').timepicker('setTime', gon.end_time);
	
	$('#instrument_select').change(function(){
		$.ajax({
	    	url: "/update_teachers",
	        data: {
	          instrument_id : $('#instrument_select').val()
	        },
	        type: "GET",
			success: function(result)
			{
				$('#teacher_list').html(result).show();
			}
	   	});
	 });
});

