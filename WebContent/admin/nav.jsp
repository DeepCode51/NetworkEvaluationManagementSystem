<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>操作记录部分</title>
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
 		.index_title {
 			/*width: 100px;*/
 			height: 30px;
 			line-height: 30px;
 			border: 1px solid green;
 			text-align: center;
 			margin-left: 9px;
 			cursor: pointer;
 			border-radius: 3px;
 		}
 		sup {
 			cursor: pointer;
 		}
 		sup:hover {
 			background-color: gray;
 			color: red;
 		}
 	</style>
</head>
<body>
	<div style="width: 100%; height: 30px; border-bottom: 1px solid #E5E5E5;">
		<div id="head-nav-show" style="width: 100%; height: 100%;">
			
		</div>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
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
    			$(this).css("border-bottom", "1px solid orange").css("cursor", "pointer");
    		}).mouseout(function() {
    			$(this).css("border-bottom", "1px solid #E5E5E5");   			
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
    </script>
</body>
</html>