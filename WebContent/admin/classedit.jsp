<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>部门信息编辑</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link href="${path }/css/form-public.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
</head>
<body>
	<div style="text-align: center;">
		<form:form action="class" method="POST" modelAttribute="editClass">
			<!-- 修改情况下才显示编号 -->
			<c:if test="${editClass.classId != null }">
				<b class="form-title">部门编号：</b><form:input class="ipt" path="classId" readonly="readonly" unselectable='on' onfocus='this.blur()' />
				<input type="hidden" value="PUT" name="_method" />
				<br /><br />
			</c:if>
			<b class="form-title">部门名称：</b><form:input path="className" class="ipt" />
			<br /><br />
			<b class="form-title">所属部门：</b><form:select path="grade.gradeId" items="${grades }"
				itemLabel="gradeName" itemValue="gradeId" class="sel"></form:select>
			<br /><br />
			<b class="form-title">HR&nbsp;&nbsp;：</b><form:select path="teacher.teacherId" items="${teachers }"
						itemLabel="teacherName" itemValue="teacherId" class="sel"></form:select>
			<br /><br />
			<!-- 存放上一个班主任编号 -->
			<input type="hidden" value="${editClass.teacher.teacherId }" name="lastTeacher" />
			<input class="sub" type="submit" value="提交"/>
		</form:form>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/form-public.js"></script>
</body>
</html>