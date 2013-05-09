$(document).ready(function(){
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