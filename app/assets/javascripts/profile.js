var wallpaperIds = [];

// Show download link when wallpapers are selected
// Hide download link when no wallpapers are selected
function toggleDownloadLink() {
	if(wallpaperIds.length > 0) {
		$('#download-link').fadeIn('slow');
	} else {
		$('#download-link').fadeOut('slow');
	}
}

$( document ).ready(function(){

	// When a thumb is clicked a border is drawn 
	// around it to indicate that it is selected
	// and the id of that wallpaper is added to an array.
	// Clicking again on the same thumbnail removes the 
	// border and removes the id from the array.
	// Note that the actuall submission is done through a 
	// hidden field on the navbar.
	$('.wallpaper-img').click(function(){
		var id = $(this).data('wallpaper-id');

		if($.inArray(id, wallpaperIds) == -1) {
			wallpaperIds.push(id);	
			addOutline(this, 'selected-thumb');
		} else {
			var index = wallpaperIds.indexOf(id);
			wallpaperIds.splice(index, 1);
			removeOutline(this, 'selected-thumb');
		};

		$('#ids').val(wallpaperIds);
		toggleDownloadLink();
	});
});