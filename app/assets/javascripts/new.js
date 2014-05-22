$( document ).ready(function(){

	$("#arrow-right").click(function() {
		$("#quote-box-wrapper").diagonalFade({
			time: 300,
			fadeDirection_x: 'right-left', // "left-right" || "right-left"
			fade: 'out',                   // "in" || "out"
			}).animate({
	      "left": "-60px"
      }, {duration: 300, queue: false}, function() {
    });
	});


	// Colours swatches based on the data coming in from the
	// colours schemes in the database.
	var colorsLocations = $('.swatch-color')

	for(i = 0; i < colorsLocations.length; i++ ) {
		$(colorsLocations[i]).css("background-color", $(colorsLocations[i]).data("color"));
	};

});
