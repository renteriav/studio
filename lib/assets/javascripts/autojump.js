//  $.autojump can be called inside a function with unlimited 
//  number of field id's as arguments i.e. 
//  $(function(){
//	$.autojump(["field_id_1", "field_id_2", "field_id_3"]); 
//  });
//
//  The maxlength for each field needs to be defined.
//  Also the field needs to belong to the autojump class. 

	jQuery.autojump = function(field_array){
		$('.autojump').keyup(function(e){
			if(e.which == 37 || e.which == 39){}
				else{
				var length = $(this).val().length;
				if (length == $(this).attr("maxlength")){
					var id = $(this).attr("id");
					var index = field_array.indexOf(id);
					var next_field = field_array[index + 1];
					$('#'+ next_field).focus();
				}
			}
		});
		$('.autojump').keydown(function(e){
			var length = $(this).val().length;
			if (length == 0){
				if(e.which == 8){
					var id = $(this).attr("id");
					var index = field_array.indexOf(id);
					var previous_field = field_array[index - 1];
				$('#'+ previous_field).focus();
				}
			}
		});
	}