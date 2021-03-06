$(document).ready(function(){
	
  if($('#day').length > 0){
	
	var scrollCookie = $.cookie('scroll_cookie');
	$.removeCookie('scroll_cookie');
	$(document).scrollTop(scrollCookie);
	
	$('.link-button')
	  .button()
	  .css({visibility: "visible"});
	
	$("#date-select").datepicker({
		onSelect: function(date, instance) {
			var newdate = new Date(date);
			var ms = newdate.valueOf();
			var timeStamp = ms/1000;
			window.location = "?date="+timeStamp;
		}
	});	
		
	$('#date-select').val(gon.date);
	
	var scroll = 1000;
	$(".event").each(function(){
		var topVal = $(this).position().top;
		if(topVal<scroll)
		{
			scroll = topVal;
		}
	});
	if (scrollCookie === undefined)
	{
	$(document).scrollTop(scroll);
	}
	
//  dialog for attendance	
	
	$('.event').click(function(){
		var id = $(this).attr('id').split("-");
		if (id[1] == "lesson" || id[1]== "extra"){
			$.ajax({
	    		url: "/attendances/dialog",
	        	data: id[1]+"_id="+id[0]+"&date="+gon.ruby_date,
	        	type: "GET",
				success: function(result)
				{
					$('#attendance-dialog').html(result);
				}
	   		}); 
		
			$( "#attendance-dialog" ).dialog(
				{buttons:[
                	{
                    	text: "Cancel", click: function() {
                        	$( this ).dialog( "close" );
							$('html').css("overflow", "scroll");
                    	}
                	},
                	{
                		text: "Submit", click: function() {
							var scrollCookie = $(document).scrollTop();
							$.cookie('scroll_cookie', scrollCookie);
							$('#submit').trigger('click');
							$('html').css("overflow", "scroll");
                    	}
                	}
            		]},
            	{"modal": true}
        	);
		}
		else if (id[1] == "sharing"){
			window.location = 'sharings/'+ id[0]; 
		}
		else{
			alert("unknown type");
		};
	});
  }
  $( "#attendance-dialog" ).on("dialogopen", function(event, ui) {
  		$('html').css("overflow", "hidden");
    	setTimeout(function(){
  		$('.radio').on("change", function(){
        	if($('#cancel_radio').is( ":checked" )){
  				$('#cancel_cbx').prop( "disabled", false );
  				$('#cancel_cbx').prop("checked", true);
  				$('.checkbox').removeClass("disabled_input");
  			}
  			else{
  				$('#cancel_cbx').prop("disabled", true);
  				$('#cancel_cbx').prop("checked", false);
  				$('.checkbox').addClass("disabled_input");
  			}
  		});
  	}, 1000);
  });

});