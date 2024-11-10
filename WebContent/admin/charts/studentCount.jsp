<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>部门人数统计</title>
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
    	li {list-style: none;}
    	a{text-decoration:none;}
		a:HOVER{text-decoration: none;}
		a:link{text-decoration:none; }
		a:visited{text-decoration:none; }
		a:active{text-decoration:none;}
		li a {cursor: pointer;}
    </style>
</head>
<body>
	
	<div style="width: 100%; height: 100%;">
		<div style="width: 100%; height: 100%;float: left;matgin-bottom:10px;">
			<c:forEach items="${grades }" var="grade">
				<button type="button" class="btn btn-info btn-sm" onclick="loadShopLine(${grade.gradeId })">${grade.gradeName }</button>
			</c:forEach>
			<button type="button" class="btn btn-info btn-sm" onclick="loadShopLine(-1)">全部</button>
		</div>
		<div id="studentCount" style="width:1000px; height: 400px; float: left; border: 1px solid #E5E5E5;"></div>
	</div>
	<script type="text/javascript">
		var studentCount = echarts.init(document.getElementById("studentCount"), "shine");
		
		//加载数据
		function loadShopLine(flag) {
			studentCount.clear();
			studentCount.showLoading({text: "图表正在努力加载中..."});
			$.getJSON("stuCount"+(flag==-1?"":"?gradeId="+flag), function(json) {
				studentCount.setOption(json, true);
				studentCount.hideLoading();
			});
		}
		
		//载入折线图
		loadShopLine(-1);
	</script>
</body>
</html>