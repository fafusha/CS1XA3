$(document).ready(function(){

	//Intialy Hidden Elements
	$(function () {
		$("#p3, #p4, #pylib, #rlib, #jslib").hide();
 	});

	// Drop Down Sections main CV content
	$("#t1").click(function(){
		$("#p1").slideToggle("fast");
	});

	$("#t2").click(function(){
		$("#p2").slideToggle("fast");
	});

	$("#t3").click(function(){
		$("#p3").slideToggle("fast");
	}); 
	$("#p4").slideToggle("fast")

	$("#t4").click(function(){
		$("#p4").slideToggle("fast");
	});


	// Drop Down Section Techinacal Skills content
	$("#py").click(function(){
		$("#pylib").slideToggle("fast");
	});
	$("#r").click(function(){
		$("#rlib").slideToggle("fast");
	});
	$("#js").click(function(){
		$("#jslib").slideToggle("fast");
	});

	// Runaway Photo

	var window_width = window.innerWidth;
	var window_height = window.innerHeight;

	$("#photoplace").mouseenter(function(){

		move_y = Math.floor(Math.random()*window_height);
		move_x = Math.floor(Math.random()*window_width);

		var move_y_str_run = "-=" + move_y.toString() + "px";
		var move_x_str_run = "-=" + move_x.toString() + "px";
		$("#photo").animate({
			bottom: move_y_str_run,
			left: move_x_str_run
		});
	});

	$("#photoplace").mouseleave(function(){
		var move_y_str_back = "+=" + move_y.toString() + "px";
		var move_x_str_back = "+=" + move_x.toString() + "px";
		$("#photo").animate({
			bottom: move_y_str_back,
			left: move_x_str_back
		});
	});

	// Dark Mode and Light mode
	var mode = "light"

	$("#dmb").click(function(){
		if (mode == "light"){
			mode = "dark";
			document.getElementById("dmb").innerHTML = "Light Mode";
			document.getElementById("ss").setAttribute("href", "style_dark.css")
		}
		else{
			mode = "light";
			document.getElementById("dmb").innerHTML = "Dark Mode";
			document.getElementById("ss").setAttribute("href", "style_light.css")
		}

	});



});