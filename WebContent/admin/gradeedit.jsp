<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
 	<link href="${path }/css/form-public.css" rel="stylesheet" />
</head>
<body>

	<div style="text-align: center;">
		<form:form action="grade" method="POST" modelAttribute="grade">
			<c:if test="${grade.gradeId != null }">
				部门编号：<form:input path="gradeId" readonly="readonly" unselectable='on' onfocus='this.blur()' class="ipt" />
				<input type="hidden" value="PUT" name="_method" class="ipt" />
			</c:if>
			<br /><br />
			部门名称：<form:input path="gradeName" class="ipt" />
			<br /><br />
			<input type="submit" value="提交" class="sub" />		
		</form:form>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/form-public.js"></script>
</body>
</html>