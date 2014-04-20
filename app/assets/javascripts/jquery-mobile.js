$(document).bind("mobileinit", function(){
  $.mobile.defaultPageTransition = "slide";
});

$(document).on('click touchstart', '.radio', function () {
  setTimeout(function(){
 	if($("#cancel-radio-label").hasClass( "ui-radio-on" )){
		$('.ui-checkbox').removeClass("ui-state-disabled");
		$("input[type='checkbox']").checkboxradio("enable");	
		$("input[type='checkbox']:first").prop("checked", true).checkboxradio("refresh");
	}
	else{
		$("input[type='checkbox']").checkboxradio("disable");
		$("input[type='checkbox']:first").attr("checked", false).checkboxradio("refresh");
		$('.ui-checkbox').addClass("ui-state-disabled");
	}
  }, 400);
});

$(document).ready(function(){
	$("#datebox").change(function(){
			var dateboxVal = $("#datebox").val();
		var newdate = new Date(dateboxVal);
		var ms = newdate.valueOf() + newdate.getTimezoneOffset() * 60000;
		var timeStamp = ms/1000;
		window.location = "?date="+timeStamp;
		$('#datebox').val(gon.date);
	});
	$('#datebox').val(gon.date);
});
