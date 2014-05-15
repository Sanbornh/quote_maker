$(document).ready(function(){
	var time = 750;

	$("#arrow_right").click(function(){

    $("#quote_field").animate({
    	marginLeft:"-=20%",
    	opacity:"0"
		},time);

    $("#colour_field").animate({
    	marginLeft:"-=20%",
    	opacity:"1"
    },time);
    
    //$("#colour_field").css("display","initial",time);
    	
		
		$("#arrow_left").fadeIn(1000);

		


  });

});