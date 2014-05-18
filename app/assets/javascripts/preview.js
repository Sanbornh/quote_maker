$(document).ready(function(){

	var background = $('#preview-background').data('background-color');
	var quote = $('#quote').data('font-color');

	$('#preview-background').css('background-color', background);
	$('#quote').css('color', quote);

}) 
