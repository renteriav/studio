$(document).ready(function(){
	$('#timepicker_start').timepicker('setTime', gon.start_time);

	$('#timepicker_end').timepicker('setTime', gon.end_time);
	
	function calculateMinutes(handler){
		var time_start = $(handler).val();
		var hour = parseInt(time_start.substr(0,2), 10);
		var minutes = parseInt(time_start.substr(3,2), 10);
		var meridian = time_start.substr(6,2);
		if (meridian == "PM"&& hour < 12 ){
			hour = hour + 12;
		}
		else if (meridian == "AM" && hour == 12){
			hour = 0;
		}
		var total_minutes = hour*60 + minutes;
		return(total_minutes);
	}
	
	function minutesToString(total_minutes){
		var minutes = (total_minutes%60).toString();
		if(minutes.length < 2){
			minutes = "0" + minutes;
		}
		var hour = Math.floor(total_minutes/60);
		if(hour < 12){
			var meridian = "AM";
		}
		else{
			var meridian = "PM";
		}
		if(hour > 12){
			hour = hour - 12;
		}
		else if(hour == 0){
			hour = 12;
		}
		hour = hour.toString();
		if(hour.length < 2){
			hour = "0" + hour;
		}
		
		var hour_string = hour + ":" + minutes + " " + meridian;
		return hour_string;
	}
	
	function minutesToDb(total_minutes){
		var minutes = (total_minutes%60).toString();
		if(minutes.length < 2){
			minutes = "0" + minutes;
		}
		var hour = Math.floor(total_minutes/60);
		var hour_string = hour + ":" + minutes + ":" + "00";
		return hour_string;
	}
	
	
	$('#timepicker_start, #timepicker_end').timepicker().on('hide.timepicker', function() {
		var start_time = calculateMinutes("#timepicker_start");
		var end_time = calculateMinutes("#timepicker_end");
		if(end_time - start_time < 30){
			var new_end_time = start_time + 30;
			if(new_end_time >= 24*60){
				new_end_time = new_end_time - 24*60;
			}
			var end_time_string = minutesToString(new_end_time);
			$('#timepicker_end').timepicker('setTime', end_time_string);
		}
	});

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
	 
 	$('.lesson_field').change(function(){
		var lesson_id = $("#lesson_id").val();
 		var teacher_id = $("#teacher_list").val();
 		
		var start_time_db = minutesToDb(calculateMinutes("#timepicker_start"));
		var end_time_db = minutesToDb(calculateMinutes("#timepicker_end"));
		var controller = $("#current_page").val();
		var start_month = ("0" + $("#lesson_start_date_2i").val()).slice(-2);
		var start_day = ("0" + $("#lesson_start_date_3i").val()).slice(-2);
		var start_year = $("#lesson_start_date_1i").val();
		var end_month = ("0" + $("#lesson_end_date_2i").val()).slice(-2);
		var end_day = ("0" + $("#lesson_end_date_3i").val()).slice(-2);
		var end_year = $("#lesson_end_date_1i").val();
		var room_id = $("#lesson_room_id").val();
		var extra_room_id = $("#extra_room_id").val();
		if(controller == "lessons"){
			if(start_month != "" && start_day != "" && start_year != "" && room_id != ""){
				var start_date = start_year + "-" + start_month + "-" + start_day;
			}
			else{
				var start_date = "";
			}
			var lesson_weekday = $("#lesson_weekday").val();
		}
		else{
			var start_date = $("#extra_date").val();
			if(start_date != ""){
			d = new Date(start_date);
			d = new Date(d.valueOf() + d.getTimezoneOffset() * 60000);
			var lesson_weekday = d.getDay();
			}
			else{
				var lesson_weekday = "";
			}
		}
		var end_date = end_year + "-" + end_month + "-" + end_day;
		
		var url_string = "/" + controller + "/teacher_booking";
 		if(teacher_id != "" && start_date != "" && lesson_weekday !== ""){
			var dataString = 'lesson_id=' + lesson_id + '&teacher_id=' + teacher_id + '&lesson_weekday=' + lesson_weekday + '&start_time_db=' + start_time_db + '&end_time_db=' + end_time_db + '&start_date=' + start_date + '&end_date=' + end_date + '&room_id=' + room_id + '&extra_room_id=' + extra_room_id;
			$.ajax({
				type: "GET",
				url: url_string,
				data: dataString,
				success: function(result)
				{
					$('#teacher_booking_alert').html(result);
				}
			});
			//alert(dataString);
		}
 	});
	
	$('#remote_submit').click(function(){
		if($('#teacher_booking_alert').html() != "" ){
			$('html').css("overflow", "hidden");
			$( "#teacher_booking_alert" ).dialog({
				buttons:[
	                {
	                    text: "Cancel", click: function() {
	                    	$('#remote_submit').removeClass('delete');
	                        $( this ).dialog( "close" );
							$('html').css("overflow", "scroll");
	                    }
	                },
	                {
	                	text: "Book", click: function() {
							$('#remote_submit').addClass('ok');
							$('#remote_submit').trigger('click');
	                        $( this ).dialog( "close" );
							$('html').css("overflow", "scroll");
	                    }
	                }
	            ],
	            modal: true
	        });
			$('#teacher_booking_alert').on( "dialogclose", function( event, ui ) {
				$('html').css("overflow", "scroll");
			});
			$(".ui-button-icon-primary").addClass("alert-icon");
			$(".ui-dialog").addClass("alert-dialog");
			$(".ui-widget-header").addClass("alert-header");
			$(".ui-widget-content").addClass("alert-content");
			$(".ui-dialog-content").addClass("alert-content");
			$(".ui-dialog-buttonpane").addClass("alert-buttonpane");
			$(".ui-button").addClass("alert-button");
			
			if ($('#remote_submit').hasClass('ok')){
				return true;
			}
			else{ 
			return false;
			}
		}
		else{
			return true;
		}
	});
	
	jQuery.liveSearch = function(keyword1, keyword2){
		var dataString = 'keyword1=' + keyword1 + '&keyword2=' + keyword2;
		$.ajax({
			type: "GET",
			url: "/customers/live_search",
			data: dataString,
			success: function(result)
			{
				$('.live_search_box').html(result).show();
			}
		});
		return false;
	}
});

