// Adds value to a hidden field based on the value
// of a data-attribute associated with the element passed in.
// Note that this relies on a standard naming convention 
// for data attribues of the form data-form-val.
function addValToForm(field, elem) {
  var formVal = $(elem).data('form-val');
  $(field).val(formVal); 
}

function addOutline(clicked, outlineClass, divOptions) {
 $(clicked).addClass(outlineClass);            // Outline swatch
  // Ensure only one swatch is selected at a time
  for(i = 0; i < divOptions.length; i++) {
    if($(divOptions[i]).hasClass(outlineClass) && (divOptions[i] !== clicked)) {
      $(divOptions[i]).removeClass(outlineClass);
    }
  };
}

// To be called on an array. It will populate a form with a value
// and highlight the selected item.
$.fn.selectWallpaperAttribute = function (formField, outlineClass){
  var divOptions = this;

  divOptions.click(function() {
    var clicked = this

    addValToForm(formField, clicked)
    addOutline(clicked, outlineClass, divOptions)
  });
};

// Sets validations on the main form
var validator = new FormValidator('wallpaper-form', [{
  name: 'wallpaper[quote]',
  display: 'quote',
  rules: 'required'
}, {
  name: 'wallpaper[colour_scheme_id]',
  display: 'colour scheme',
  rules: 'required'
}, {
  name: 'wallpaper[layout_scheme_id]',
  display: 'layout',
  rules: 'required'
}], function(errors, event) {
    if (errors.length > 0) {
      console.log(errors);
    }
});

// Define custom error message for failed validations
validator.setMessage('required', 'Oops, looks like you forgot to enter a %s.')

// Flow starts here 
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
  $('.swatch').selectWallpaperAttribute('#wallpaper_colour_scheme_id', 'selected-color');
  $('.layout-scheme').selectWallpaperAttribute('#wallpaper_layout_scheme_id', 'selected-layout');

  // Toggle modal
  $('#about-button').click(function() {
    $('.overlay-wrapper').show();
  });

  $('#close-modal').click(function() {
    $('.overlay-wrapper').hide();
  })

});




