<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Insert title here</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<style type="text/css">
 		.totalDiv {
 			height: 100px;
 			border: 1px solid #DDDDDD;
 			line-height: 100px;
 			margin-left: 65px;
 			margin-top: 31px;
 			border-radius: 3px;
 		}
 		.totalTitle {
 			float: left;
 			width: 40%;
 			height: 100%;
 			line-height: 100px;
 			text-align: center;
 			margin-left: -15px;
 		}
 		.totalValue {
 			float: right;
 			width: 50%;
 			height: 100%;
 			line-height: 100px;
 			text-align: center;
 		}
 		.val {
 			font-size: 30px;
 			font-weight: 700;
 		}
 		h1 {
 			color: #FFF;
 		}
 	</style>
</head>
<body style="text-align: center;">
	<div class="alert alert-block alert-success">
		<button class="close" data-dismiss="alert" type="button" style="text-align: center;">
			<img src="${path }/images/admin/x.png" />
		</button>
		<i class="icon-ok green"></i>
		欢迎使用
		<strong>
			后台管理系统
			<small>(v2.0)</small>
		</strong>
		, 努力做教育服务
	</div>
	<div class="state-overview clearfix">
		<div class="col-lg-3 col-sm-5 totalDiv">
			<div class="totalTitle" id="examPaperTotal">
				<h1></h1>
			</div>
			<div class="totalValue">
				<span class="val"></span>
			</div>
		</div>
		<div class="col-lg-3 col-sm-5 totalDiv">
			<div class="totalTitle" id="subjectTotal">
				<h1></h1>
			</div>
			<div class="totalValue">
				<span class="val"></span>
			</div>
		</div>
		<div class="col-lg-3 col-sm-5 totalDiv">
			<div class="totalTitle" id="teacherTotal">
				<h1></h1>
			</div>
			<div class="totalValue">
				<span class="val"></span>
			</div>
		</div>
		<div class="col-lg-3 col-sm-5 totalDiv">
			<div class="totalTitle" id="studentTotal">
				<h1></h1>
			</div>
			<div class="totalValue">
				<span class="val"></span>
			</div>
		</div>
	</div>

	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
    	$(function() {
    		$.getJSON("../homeInfo", function(data) {
    			$.each(data, function(key, item) {
    				if("examPaperTotal" == key.trim()) {
    					$("#examPaperTotal").css("background-color", "#6CCAC9");
    					$("#examPaperTotal").children("h1").text("试卷数量");
    					$("#examPaperTotal").siblings(".totalValue").children("span").text(item+"套");
    				} else if("subjectTotal" == key.trim()) {
    					$("#subjectTotal").css("background-color", "#FF6C60");
    					$("#subjectTotal").children("h1").text("题目数量");
    					$("#subjectTotal").siblings(".totalValue").children("span").text(item+"道");
    				} else if("teacherTotal" == key.trim()) {
    					$("#teacherTotal").css("background-color", "#F8D347");
    					$("#teacherTotal").children("h1").text("HR人数");
    					$("#teacherTotal").siblings(".totalValue").children("span").text(item+"人");
    				} else if("studentTotal" == key.trim()) {
    					$("#studentTotal").css("background-color", "#57C8F2");
    					$("#studentTotal").children("h1").text("员工人数");
    					$("#studentTotal").siblings(".totalValue").children("span").text(item+"人");
    				}
    			});
    		});
    	});
    </script>
</body>
</html>