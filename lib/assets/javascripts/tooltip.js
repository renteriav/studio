$(document).ready(function(){
	
	$(document).tooltip();
	
	$(".tooltip_right").tooltip({ 
		position: { my: "left+15 center", at: "right center" } 
	});
	
	$(".tooltip_right").click(function(){
		$(".tooltip_right").tooltip("close");
	}); 
	
});