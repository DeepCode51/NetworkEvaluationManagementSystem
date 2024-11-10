<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>测评历史信息</title>
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
					<th>试卷名称</th>
					<th>试卷总分</th>
					<th>试题数量</th>
					<th>测评得分</th>
					<th>测评人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty historys }">
						<c:forEach items="${historys }" var="history">
							<tr>
								<td>${history.examPaper.examPaperName }</td>
								<td>${history.examPaper.examPaperScore }</td>
								<td>${history.examPaper.subjectNum }</td>
								<td>
									<c:if test="${history.examScore < history.examPaper.examPaperScore*0.6 }">
										<span style="color: red;"><b>${history.examScore }</b></span>
									</c:if>
									<c:if test="${history.examScore > history.examPaper.examPaperScore*0.6 }">
										<span style="color: green;"><b>${history.examScore }</b></span>
									</c:if>
								</td>
								<td>${history.student.studentName }</td>
								<td>
									<div class="btn-group">
										<a href="review?studentId=${history.student.studentId }&examPaperId=${history.examPaper.examPaperId }&score=26&examPaperName=${history.examPaper.examPaperName }&studentName=${history.student.studentName }" class="btn btn-info btn-sm">详情</a>
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