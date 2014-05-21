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
});

// $(document).ready(function(){
// 	var time = 750;
// 	var click = 0;


// 	function moveHide(target){
// 		$(target).animate({
//     	marginLeft:"-=60%",
//     	opacity:"0"
// 		},time);
// 	}

// 	function moveShow(target){
// 		$(target).animate({
// 	    	marginLeft:"-=60%",
// 	    	opacity:"1"	    	
// 	    },time);
// 	}

// 	$("#arrow_right").click(function(){

// 		if(click==2){
// 			moveHide("#layout_field");
// 			$("submit_field").css("display","auto");
// 			moveShow("#submit_field");
// 			$("#arrow_right").fadeOut();
// 		}

// 		if(click==1){
// 			moveHide("#colour_field");
// 			moveShow("#layout_field");
// 			click++;
// 		}

// 		if(click==0){
// 			moveHide("#quote_field");
// 			moveShow("#colour_field");
// 			//$("#arrow_left").fadeIn(1000);
// 			click++;	
// 		}
// 	});

// 	function layout_selection(image, radio_id){
// 		$(image).click(function(){
// 			$(radio_id).attr('checked',true);
// 			$(this).addClass("glow");
// 		});
// 	}

// 	// layout_selection("#top","#wallpaper_layout_scheme_1");
// 	// layout_selection("#middle","#wallpaper_layout_scheme_2");
// 	// layout_selection("#bottom","#wallpaper_layout_scheme_3");



// });//doc ready