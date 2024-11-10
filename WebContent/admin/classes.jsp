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
</head>
<body>

	<div>
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th>部门编号</th>
					<th>部门名称</th>
					<th>所属部门</th>
					<th>HR名字</th>
					<c:if test="${sessionScope.adminPower == 1 }">
						<th>操作
							&emsp;
							<a href="preAddClass" class="btn btn-xs btn-info">添加</a>
						</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty classes }">
						<c:forEach items="${classes }" var="clazz">
							<tr>
								<td>${clazz.classId }</td>
								<td>${clazz.className }</td>
								<td>${clazz.grade.gradeName }</td>
								<td>
									<c:if test="${clazz.teacher.teacherName == null }">
										待定
									</c:if>
									<c:if test="${clazz.teacher.teacherName != null }">
										${clazz.teacher.teacherName }
									</c:if>
								</td>
								<td>
									<c:if test="${sessionScope.adminPower == 1 }">
										<div class="btn-group">
											<button type="button" class="btn btn-info btn-sm" onclick="update('edit/class/${clazz.classId }')">修改</button>
											<button type="button" class="btn btn-danger btn-sm" onclick="del('del/class/${clazz.classId }')">删除</button>
										</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</tbody>
		</table>
		<form action="class" method="post">
			<input type="hidden" value="DELETE" name="_method" />
		</form>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/handle.js"></script>
</body>
</html>