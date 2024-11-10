<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>测评安排信息</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
</head>
<body>

	<div>
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th>编号</th>
					<th>测评部门</th>
					<th>测评科目</th>
					<th>试卷名称</th>
					<th>题目数量</th>
					<th>开测时间</th>
					<th>操作
						&emsp;
						<a type="button" onclick="_iframe(0, 'preAddep', 'examPlans')" class="btn btn-xs btn-info" target="right">添加</a>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty examPlans }">
						<c:forEach items="${examPlans }" var="plan">
							<tr>
								<td>${plan.examPlanId }</td>
								<td>${plan.clazz.className }</td>
								<td>${plan.course.courseName }</td>
								<td>${plan.examPaper.examPaperName }</td>
								<td>${plan.examPaper.subjectNum }</td>
								<td>${plan.beginTime }</td>
								<td>
									<div class="btn-group">
										<button type="button" class="btn btn-info btn-sm" onclick="_iframe(1,'preUpdateep/${plan.examPlanId }', 'examPlans')">修改</button>
										<a href="del/${plan.examPlanId }" class="btn btn-danger btn-sm">移除</a>
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
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/handle.js"></script>
    <script src="${path }/js/add-update.js"></script>
</body>
</html>