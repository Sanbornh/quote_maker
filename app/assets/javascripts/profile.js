var wallpaperIds = [];

$( document ).ready(function(){

	// When a thumb is clicked a border is drawn 
	// around it to indicate that it is selected
	// and the id of that wallpaper is added to an array.
	// Clicking again on the same thumbnail removes the 
	// border and removes the id from the array.
	$('.wallpaper-img').click(function(){
		var id = $(this).data('wallpaper-id');

		if($.inArray(id, wallpaperIds) == -1) {
			wallpaperIds.push(id);	
			$(this).addClass( 'selected-thumb' );
		} else {
			var index = wallpaperIds.indexOf(id);
			wallpaperIds.splice(index, 1);
			$(this).removeClass( 'selected-thumb' );
		};

		$('#ids').val(wallpaperIds);
	});

});