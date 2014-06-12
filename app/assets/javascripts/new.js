var currentField = 0;
var formFields = [
	"#quote-box-wrapper",
	"#citation-box-wrapper",
	"#swatches-wrapper",
	"#layout-thumbs-wrapper",
	"#generate-wrapper"
];

// Currently handles selecting an attribute by A) highlighting the thing clicked on
// and B) adding it's value to a hidden form.
// This should likely be broken into several functions.
$.fn.selectWallpaperAttribute = function(formField, formValue, outlineClass){
	var divOptions = this;

	$(divOptions).click(function(env) {

		var clicked = env.currentTarget
		var swatches = $(divOptions)

		$(formField).val($(clicked).data(formValue));
		$(clicked).addClass( outlineClass );

		for(i = 0; i < swatches.length; i++ ) {
			if($(swatches[i]).hasClass(outlineClass) && (swatches[i] != this)) {
				$(swatches[i]).removeClass(outlineClass);
			}
		};
	});
};


$( document ).ready(function(){

	// Advance form field by one step
	$("#arrow-right").click(function() {
		if(currentField != formFields.length - 1) {
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
		}
	});

	// Revert form field by one step
	$("#arrow-left").click(function() {
		if(currentField != 0 ) {
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
		}
	});

	// Colours swatches based on the data coming in from the
	// colours schemes in the database.
	var colorsLocations = $('.swatch-color')

	for(i = 0; i < colorsLocations.length; i++ ) {
		$(colorsLocations[i]).css("background-color", $(colorsLocations[i]).data("color"));
	};

	$('.swatch').selectWallpaperAttribute('#wallpaper_colour_scheme_id', 'color-scheme-id', 'selected-color');
	$('.layout-scheme').selectWallpaperAttribute('#wallpaper_layout_scheme_id', 'layout-scheme-id', 'selected-layout');
	
});
