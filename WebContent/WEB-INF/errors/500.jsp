<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>500</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link rel="stylesheet" href="${path }/js/jquery404/css/404.css" />
	<script type="text/javascript" src="${path }/js/jquery.js" ></script>
</head>
<body>
		<div class="code">
			<p>ERROR 500</p>
		</div>
		<div class="road">
			<div class="shadow">
				<div class="shelt">
					<div class="head">
						<div class="eyes">
							<div class="lefteye">
								<div class="eyeball"></div>
								<div class="eyebrow"></div>
							</div>
							<div class="righteye">
								<div class="eyeball"></div>
								<div class="eyebrow"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="hat"></div>
				<div class="bubble">
					<a href="javascript:history.go(-1)">Go back Page?</a>
				</div>
			</div>
			<p>The Server is Tired</p>
		</div>
		<script type="text/javascript" src="${path }/js/jquery404/js/404.js" ></script>
	</body>
</html>