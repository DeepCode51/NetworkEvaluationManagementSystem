<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>员工测评次数统计</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/echarts/echarts.js"></script>
    <script src="${path }/js/echarts/shine.js"></script>
    <style type="text/css">
    	li {list-style: none;float: left;margin-left: 9px;}
    	a{text-decoration:none;}
		a:HOVER{text-decoration: none;}
		a:link{text-decoration:none; }
		a:visited{text-decoration:none; }
		a:active{text-decoration:none;}
		li a {cursor: pointer;}
    </style>
</head>
<body>
	<%--所有员工测评次数，后面的图表可替代 --%>
	<%-- 
	<div style="width: 100%; height: 500px;">
		<div style="width: 104px; height: 100%;float: left; margin-left: 10px;">
			<span style="display: none;" id="tid">${sessionScope.loginTeacher.teacherId }</span>
			<strong>描述：</strong>
			<p style="font-size: 12px;">当前图表所描述的为
				本班员工测评次数
			</p>
		</div>
		<div id="studentExamCount" style="margin-left: 100px; width:750px; height: 400px; float: left; border: 1px solid #E5E5E5;"></div>
	</div>
	<script type="text/javascript">
		var studentExamCount = echarts.init(document.getElementById("studentExamCount"), "shine");
		
		//加载数据
		function loadShopLine(flag) {
			studentExamCount.clear();
			studentExamCount.showLoading({text: "图表正在努力加载中..."});
			$.getJSON("../../examCount?tid="+$("#tid").text().trim(), function(json) {
				if(json == "TID-NULL") {
					$("#studentExamCount").html("<h1>请登录后再查看</h1>");
					alert("请登录后再查看");
				} else {
					studentExamCount.setOption(json, true);
					studentExamCount.hideLoading();
				}
			});
		}
		
		//载入折线图
		loadShopLine(-1);
	</script> --%>
	
	<div style="width: 100%; height: 500px;">
		<div style="width: 104px; height: 100%;float: left; margin-left: 10px;">
			<span style="display: none;" id="tid">${sessionScope.loginTeacher.teacherId }</span>
			<strong>描述：</strong>
			<p style="font-size: 12px;">当前图表所描述了本班
				所有员工测评信息
			</p>
			<div>
				<strong>部门员工：</strong>
				<ul id="stusList">
					<li><a href="#" onclick="loadShopLine()">全部</a></li>
				</ul>
			</div>
		</div>
		<div id="stuExamInfo" style="margin-left: 100px; width:750px; height: 400px; float: left; border: 1px solid #E5E5E5;"></div>
	</div>
	<script type="text/javascript">
		//加载本班员工数据
		function loadStus() {
			$.getJSON("../../stus?tid="+$("#tid").text().trim(), function(json) {
				if(json == "TID-NULL") {
					$("#studentExamCount").html("<h1>请登录后再查看</h1>");
					alert("请登录后再查看");
				} else {
					var lis = "";
					$.each(json, function(index, item) {
						var li = "<li><a href='#' onclick='loadByStudent("+item.studentId+")'>"+item.studentName+"</a></li>";
 						$("#stusList").after(li);
					});
				}
			});
		}
		loadStus();
		
		
	var stuExamInfo = echarts.init(document.getElementById("stuExamInfo"), "shine");
		
		//加载数据
		function loadShopLine() {
			stuExamInfo.clear();
			stuExamInfo.showLoading({text: "图表正在努力加载中..."});
			$.getJSON("../../avgcounts?tid="+$("#tid").text().trim(), function(json) {
				if(json == "TID-NULL") {
					$("#stuExamInfo").html("<h1>请登录后再查看</h1>");
					alert("请登录后再查看");
				} else {
					stuExamInfo.setOption(json, true);
					stuExamInfo.hideLoading();
				}
			});
		}
		
		//载入折线图
		loadShopLine();
		
		function loadByStudent(studentId) {
			stuExamInfo.clear();
			stuExamInfo.showLoading({text: "图表正在努力加载中..."});
			$.getJSON("../../stuexam?stuId="+studentId, function(json) {
				if(json == "TID-NULL") {
					$("#stuExamInfo").html("<h1>请登录后再查看</h1>");
					alert("请登录后再查看");
				} else {
					stuExamInfo.setOption(json, true);
					stuExamInfo.hideLoading();
				}
			});
		}
	</script>
</body>
</html>