$(document).ready(function(){
	$('.live_search_field').bind("keyup", function(){
		var first = $("#customer_first").val();
		var last = $("#customer_last").val();
		if(first != "" || last != ""){
			$.liveSearch(first, last);
		}
		else{
			$('.live_search_box').html("")
		}
	});

	

	$('.triger').click(function(){
		$('html').css("overflow", "hidden");
		var link = $(this);

		var row = $(this).parent().parent();

		$( "#alert-dialog" ).dialog(
			{buttons:[
                {
                    text: "Cancel", click: function() {
                    	link.removeClass('delete');
                        $( this ).dialog( "close" );
                    }
                },
                {
                	text: "Delete", click: function() {
                        link.addClass('delete');
                        link.trigger('click');
                        $( this ).dialog( "close" );
                        row.css({"color": "#b94a48"});
                        row.effect('highlight', {color: "#eed3d7"}, 'slow');
                        row.hide('slow');
                    }
                }
            ]},
            {"modal": "true"}
        );
		$( "#alert-dialog" ).dialog("open");
		$(".ui-button-icon-primary").addClass("alert-icon");
		$(".ui-dialog").addClass("alert-dialog");
		$(".ui-widget-header").addClass("alert-header");
		$(".ui-dialog-content").addClass("alert-content");
		$(".ui-widget-content").addClass("alert-content");
		$(".ui-dialog-buttonpane").addClass("alert-buttonpane");
		$(".ui-button").addClass("alert-button");
		$( "#alert-dialog" ).on( "dialogclose", function( event, ui ) {
			$('html').css("overflow", "scroll");
		});
		if (link.hasClass('delete')){
			return true;
		}
		else 
		return false;
	});
});