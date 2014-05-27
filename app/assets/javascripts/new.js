var currentField = 0;
var formFields = [
	"#quote-box-wrapper",
	"#citation-box-wrapper",
	"#swatches-wrapper",
	"#layout-thumbs-wrapper"
];

$( document ).ready(function(){


	// Advance form field by one step
	$("#arrow-right").click(function() {
		$(formFields[currentField]).fadeOut(300).animate({
			'left': '-=60px'
		}, {
			duration: 500, 
			queue: false
		}, function() {});

		$(formFields[currentField + 1]).delay(300).fadeIn(300).animate({
			'right': '+=60px'
		}, {
			duration: 500, 
			queue: false
		}, function() {});

		currentField++;
	});

	// Revert form field by one step
	$("#arrow-left").click(function() {
		$(formFields[currentField]).fadeOut(300).animate({
			'right': '-=60px'
		}, {
			duration: 500, 
			queue: false
		}, function() {});

		$(formFields[currentField - 1]).delay(300).fadeIn(300).animate({
			'left': '+=60px'
		}, {
			duration: 500, 
			queue: false
		}, function() {});

		currentField--;
	});


	// Colours swatches based on the data coming in from the
	// colours schemes in the database.
	var colorsLocations = $('.swatch-color')

	for(i = 0; i < colorsLocations.length; i++ ) {
		$(colorsLocations[i]).css("background-color", $(colorsLocations[i]).data("color"));
	};



	// This function handles user selection of a colour scheme
	// by filling a hidden form field with the id of the 
	// swatch that is clicked on by the user.
	$('.swatch').click(function(env) {

		var clicked = env.currentTarget
		var swatches = $('.swatch')

		$('#wallpaper_colour_scheme_id').val($(clicked).data('color-scheme-id'));
		$(clicked).addClass( 'selected' );

		for(i = 0; i < swatches.length; i++ ) {
			console.log(i + $(swatches[i]))
			if($(swatches[i]).hasClass('selected') && (swatches[i] != this)) {
				$(swatches[i]).removeClass( 'selected' );
			}
		};
	});
});
