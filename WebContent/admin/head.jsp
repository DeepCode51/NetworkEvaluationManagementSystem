<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>后台首页头部</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<style type="text/css">
 		a{text-decoration:none;}
		a:HOVER{text-decoration: none;}
		a:link{text-decoration:none; }
		a:visited{text-decoration:none; }
		a:active{text-decoration:none;}
 	</style>
</head>
<body>
	<div style="width: 100%; height: 98px; background-color: #000000;">
		<div style="float: left; width: 380px; height: 100%;line-height:80px;margin-left: -40px;">
			<a href="index.jsp" target="_top">
				<img src="${path }/images/reception/logo_1.png" alt="WiseMan logo" style="width: 95%; height: 100%;" />
			</a>
		</div>
		<div id="head-nav-show" style="float: left; width: 300px; height: 100%;margin-left: 112px;">
			<div style="margin-top: 25px;width: 211px; height: 35px; background-color: #579EC8;line-height: 35px;text-align: center;">
				<span id="date_time" style="color: #FFF;"></span>
			</div>
		</div>
		<div id="loginTeacher" style="float:right; width: 190px; height:100%;line-height: 80px;">
			<c:if test="${sessionScope.loginTeacher != null }">
				<a target="right" class="btn btn-default" href="../teachers" style="margin-left: 9px;">
					${sessionScope.loginTeacher.teacherName }
				</a>
			</c:if>
			<c:if test="${sessionScope.loginTeacher == null }">
				<a target="right" class="btn btn-default" href="#" style="margin-left: 9px;">
					未登录
				</a>
			</c:if>
			<a class="btn btn-default" href="../exitTeacher" target="_parent">退出登录</a>
		</div>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
    	date_time();
    	$(function() {
    		$("#loginTeacher").mouseover(function() {
    			$(this).css("border-left", "2px solid #EC870E");
    		}).mouseout(function() {
    			$(this).css("border-left", "0px solid #EC870E");    			
    		});
    		$("#head-nav-show").mouseover(function() {
    			if($(".index_title").size() <= 0) {
    				return false;
    			}
    			$(this).css("border-left", "2px solid #EC870E");
    		}).mouseout(function() {
    			$(this).css("border-left", "0px solid #EC870E");    			
    		});
    	});
    	
    	function removeParent(i) {
    		//当前页处于显示状态，无法删除
    		if ($("#it"+i).attr("show") == "t") {
    			return;
    		}
    		$("#it"+i).remove();
    	}
    	
    	function changeShow(i) {
    		$(".index_title").css("background-color", "#FFF").attr("show", "f");
    		$("#it"+i).css("background-color", "#CAE5E8").attr("show", "t");
    	}
    	
    	setInterval("date_time()", 1000);
    	
    	function date_time() {
    		var date = new Date();
    		var year = date.getFullYear();
    		var month = date.getMonth()+1;
    		var day = date.getDate();
    		var hour = date.getHours();
    		var minutes = date.getMinutes();
    		var seconds = date.getSeconds();
    		if(parseInt(seconds) >= 0 && parseInt(seconds) < 10) {
    			seconds = "0"+seconds;
    		}
    		$("#date_time").text(year+"年"+month+"月"+day+"日"+hour+"时"+minutes+"分"+seconds+"秒");
    	}
    </script>
</body>
</html>