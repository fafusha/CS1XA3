$(document).ready(function(){
	$("#t1").click(function(){
		$("#p1").slideToggle("slow");
	});

	$("#t2").click(function(){
		$("#p2").slideToggle("slow");
	});

	$("#t3").click(function(){
		$("#p3").slideToggle("slow");
	}); 
	$("#p4").slideToggle("slow")

	$("#t4").click(function(){
		$("#p4").slideToggle("slow");
	});
	var fonts = [
	'"Times New Roman", Times, serif',
	'"Palatino Linotype", "Book Antiqua", Palatino, serif',
	'Georgia, serif',
	'"Comic Sans MS", cursive, sans-serif',
	'Impact, Charcoal, sans-serif',
	'"Lucida Sans Unicode", "Lucida Grande", sans-serif',
	'"Trebuchet MS", Helvetica, sans-serif'
	]


	document.getElementById("b1").onclick = function {
		var fnt = fonts[Math.floor(Math.random() * fonts.length)]
		document.getElementsByTagName("body").style.font-family=fnt
	}

});
