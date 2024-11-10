$(function() {
	$(".ipt").focus(function() {
		$(this).css("border", "1px solid D5E9F9");
	});
	
	$(".sub").mouseover(function() {
		$(this).css("background-color", "#EEEEEE");
	}).mouseout(function() {
		$(this).css("background-color", "#FFF");		
	});
});