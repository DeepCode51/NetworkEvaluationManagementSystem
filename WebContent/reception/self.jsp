<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>员工信息</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<style type="text/css">
 		.title {
 			font-size: 12px;
 		}
 		.label-val {
 			cursor: pointer;
 		}
 	</style>
</head>
<body>
	<div style="width: 400px">
		<label style="display: none;" id="stuId">${self.studentId }</label>
		<span class="title">姓&emsp;名: </span>
		<label class="label-val">${self.studentName }</label>
		<br />
		<span class="title">登录账户: </span>
		<label class="label-val">${self.studentAccount }</label>
		<br />
		<span class="title">登录密码: </span>
		<label class="label-val" val="${self.studentPwd }" id="sutdentPwd">******</label>
		<br />
		<span class="title">就读部门: </span>
		<label class="label-val">${self.classInfo.className }</label>
		<br />
	</div>	

	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
    	$(function() {
    		$("#sutdentPwd").mouseover(function() {
    			$(this).text($(this).attr("val"));
    		}).mouseout(function() {
    			$(this).text("******");    			
    		}).click(function() {
    			$(this).replaceWith("<input onblur='resetPwd(this)' id='resetPwd' type='text'></input>");
    		});
    	});
    	
    	function resetPwd(t) {
    		$.ajax({
    			type: "POST",
    			url: "reset/"+$(t).val()+"/"+$("#stuId").text(),
    			success: function(data) {
    				if(data == "t") {
    					zeroModal.show({
    						title: "提示",
    						content: "密码已重置!",
    						width : '200px',
    						height : '130px',
    						overlay : false,
    						ok : true
    					});
    					$("#resetPwd").replaceWith('<label class="label-val" id="sutdentPwd">••••••</label>');
    					$("#sutdentPwd").text($(t).val());
    				} else {
    					alert("修改失败");
    				}
    			}
    		});
    	}
    </script>
</body>
</html>