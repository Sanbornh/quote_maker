$(document).ready(function(){
	var time = 750;
	var click = 0;


	function moveHide(target){
		$(target).animate({
    	marginLeft:"-=60%",
    	opacity:"0"
		},time);
	}

	function moveShow(target){
		$(target).animate({
	    	marginLeft:"-=60%",
	    	opacity:"1"	    	
	    },time);
	}

	$("#arrow_right").click(function(){

		if(click==2){
			moveHide("#layout_field");
			$("submit_field").css("display","auto");
			moveShow("#submit_field");
			$("#arrow_right").fadeOut();
		}

		if(click==1){
			moveHide("#colour_field");
			moveShow("#layout_field");
			click++;
		}

		if(click==0){
			moveHide("#quote_field");
			moveShow("#colour_field");
			//$("#arrow_left").fadeIn(1000);
			click++;	
		}
	});

	

});