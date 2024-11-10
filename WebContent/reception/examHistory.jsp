<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>测评历史</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
</head>
<body style="background-color: #EEEEEE;">
	<div class="container" style="margin-top: 100px;">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row">
					<c:choose>
						<c:when test="${fn:length(ehps) > 0 }">
							<c:forEach items="${ehps }" var="ehp">
								<div class="col-md-4">
									<div class="thumbnail">
										<img alt="300x200" src="${pageContext.request.contextPath }/images/reception/peitu2.jpg" />
										<div class="caption">
											<h3>
												${ehp.examPaperName }
											</h3>
											<p>
												题目数量: ${ehp.subjectNum } &emsp;&emsp;
												总分: ${ehp.examPaperScore } &emsp;&emsp;
												得分: ${ehp.examScore }
											</p>
											<p class="beginTime">测评时间: 
												<c:if test="${ehp.beginTime == null }">暂未定义</c:if>
												<c:if test="${ehp.beginTime != null }">${ehp.beginTime }</c:if>
											</p>
											<p>
									 			<a class="btn btn-default btn-lg btn-block beginExam" href="../review?studentId=${sessionScope.loginStudent.studentId }&examPaperId=${ehp.examPaperId }&score=${ehp.examScore }&examPaperName=${ehp.examPaperName }">回顾试卷</a>
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							 <div class="jumbotron">
								 <h1>暂无历史测评记录</h1>
								 <p>学习，永无止境!</p>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script type="text/javascript">
    	$(function() {
    		
    	});
    </script>
</body>
</html>