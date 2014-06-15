// Currently handles selecting an attribute by A) highlighting the thing clicked on
// and B) adding it's value to a hidden form.
// Note: This should be refactored into several separate functions.
$.fn.selectWallpaperAttribute = function (formField, formValue, outlineClass){
  var divOptions = this;

  divOptions.click(function() {
    var clicked = this

    $(formField).val($(clicked).data(formValue)); // Add swatch value to form

    $(clicked).addClass(outlineClass);            // Outline swatch
    // Ensure only one swatch is selected at a time
    for(i = 0; i < divOptions.length; i++) {
      if($(divOptions[i]).hasClass(outlineClass) && (divOptions[i] !== clicked)) {
        $(divOptions[i]).removeClass(outlineClass);
      }
    };
  });
};

$( document ).ready(function() {

  var currentField = 0; 
  var formFields = $('.form-element');

  // Advance form field by one step
  $("#arrow-right").click(function() {
    if(currentField !== formFields.length - 1) {
      $(formFields[currentField]).fadeOut(300).animate({
        'left': '-=60px'
      }, {
        duration: 500, 
        queue: false
      });

      $(formFields[currentField + 1]).delay(300).fadeIn(300).animate({
        'right': '+=60px'
      }, {
        duration: 500, 
        queue: false
      });

      currentField++;
    }
  });

  // Revert form field by one step
  $("#arrow-left").click(function() {
    if(currentField !== 0 ) {
      $(formFields[currentField]).fadeOut(300).animate({
        'right': '-=60px'
      }, {
        duration: 500, 
        queue: false
      });

      $(formFields[currentField - 1]).delay(300).fadeIn(300).animate({
        'left': '+=60px'
      }, {
        duration: 500, 
        queue: false
      });

      currentField--;
    }
  });

  // Colours swatches based on the data coming in from the
  // colour schemes in the database.
  var colorsLocations = $('.swatch-color')

  for(i = 0; i < colorsLocations.length; i++ ) {
    $(colorsLocations[i]).css("background-color", $(colorsLocations[i]).data("color"));
  };

  // Outlines and populates hidden forms with swatch and layout options
  $('.swatch').selectWallpaperAttribute('#wallpaper_colour_scheme_id', 'color-scheme-id', 'selected-color');
  $('.layout-scheme').selectWallpaperAttribute('#wallpaper_layout_scheme_id', 'layout-scheme-id', 'selected-layout');

  // Toggle modal
  $('#about-button').click(function() {
    $('.overlay-wrapper').show();
  });

  $('#close-modal').click(function() {
    $('.overlay-wrapper').hide();
  })

});




