// JavaScript Document
$(document).ready(function(){
	"use strict";
	$('body').click(function(){
		$.ajax({
		url: "reset_session.php"	
	});
	});
   // console.log("test");
	setInterval(function(){
		$.ajax({
		url: "check_session.php",
		success: function(data){
			//alert(data);
			if(data==="no"){
				window.location = "login2.php";}
		}
		});	
	},60000);
});