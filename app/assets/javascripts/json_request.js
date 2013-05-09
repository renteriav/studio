/*$(document).ready(function(){
  var id = $('#id').val();
  $.ajax({
    type: "GET",
    url: "http://localhost:3000/customers/" + id + "/telephones",
    data: $(this).serialize(),
    dataType: "json",
    success: function (result) {
    	var info = "";
  		$.each(result, function(key, value){
  			$.each(value, function(k, v){
  				info += key + ": "+ k  + ", " + v + "\n"; 
  			});
  			alert(info);
  			info = "";
  		});
	 }
  });
});*/