<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>部门信息</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link href="${path }/css/public.css" rel="stylesheet" />
</head>
<body>
	<c:set var="power" value="${sessionScope.adminPower }"></c:set>
	<div>
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th>部门编号</th>
					<th>部门名称</th>
					<c:if test="${sessionScope.adminPower == 1 }">
						<th>操作
							&emsp;
							<a href="preAddGrade" class="btn btn-xs btn-info">添加</a>
						</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty grades }">
						<c:forEach items="${grades }" var="grade">
							<tr>
								<td>${grade.gradeId }</td>
								<td>${grade.gradeName }</td>
								<td>
									<div class="btn-group">
										<c:if test="${power == 1 }">
											<button type="button" class="btn btn-info btn-sm" onclick="update('grade/update/${grade.gradeId }')">修改</button>
											<button type="button" class="btn btn-danger btn-sm" onclick="del('grade/del/${grade.gradeId }')">删除</button>
										</c:if>
										<button type="button" class="btn btn-primary btn-sm lookclass" id="c${grade.gradeId }">部门</button>
									</div>
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
    <script src="${path }/js/view-link.js"></script>
</body>
</html>