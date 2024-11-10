<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>回顾试卷</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<style type="text/css">
 		li {
 			list-style: none;
 		}
 	</style>
</head>
<body style="background-color: #F7F7F7;">
	<div class="container" style="margin-top: 100px;">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row">
					<div style="border-bottom: 2px dashed #CAE5E8; text-align: center;">
						<h2>${examPaperName }</h2>
						<p>
							姓名：<u>
									<c:if test="${studentName == null }">${sessionScope.loginStudent.studentName }</c:if>
									<%--后台HR查看 --%>
									<c:if test="${studentName != null }">${studentName }</c:if>
								</u>
							&emsp;
							得分：<u>${score }</u>
							&emsp;
							测评时间：<u>${ExamedPaper.examPaperTime}</u>
						</p>
					</div>
					<c:choose>
						<c:when test="${fn:length(esms) > 0 }">
							<ul>
								<c:set value="1" var="index"></c:set>
								<c:forEach items="${esms }" var="esm">
									<li>
										<div style="border-bottom: 2px solid #FFF;margin-left: 30px;">
											<h3>${index}、${esm.subject.subjectName }</h3>
											<c:if test="${esm.subject.subjectType != 2 }">
											<p>A、${esm.subject.optionA }</p>
											<p>B、${esm.subject.optionB }</p>
											<p>C、${esm.subject.optionC }</p>
											<p>D、${esm.subject.optionD }</p>
											</c:if>
											<%--标识是否为未做题目 --%>
											<c:set value="1" var="isChoose"></c:set>
											<c:forEach items="${views }" var="view">
												<%--当前试题答案不为空，不是没做就提交的情况 --%>
												<c:if test="${esm.subject.subjectId == view.subject.subjectId }">
													<c:set value="0" var="isChoose"></c:set>
													<p>选择答案: 
														<%--答案选对 --%>
														<c:if test="${view.subject.rightResult == view.chooseResult }"><span style="color:green"><b>${view.chooseResult }</b></span></c:if>
														<%--答案选错，同时显示正确答案 --%>
														<c:if test="${view.subject.rightResult != view.chooseResult }">
															<span style="color:red">
																<b>${view.chooseResult }</b>
															</span>
															&emsp;
															正确答案: <span style="color:#F1AF00;"><b>${view.subject.rightResult }</b></span>
														</c:if>
														&emsp;
														分值: <b style="color:green;">${view.subject.subjectScore }</b>
														&emsp;
														难易程度:
														<b style="color:green;">
															<c:if test="${view.subject.subjectEasy == 0 }">简单</c:if>
															<c:if test="${view.subject.subjectEasy == 1 }">普通</c:if>
															<c:if test="${view.subject.subjectEasy == 2 }">困难</c:if>
														</b>
													</p>
												</c:if>
											</c:forEach>
											<%--未做试题 --%>
											<c:if test="${isChoose != 0 }">
												<p>选择答案: 
													<b style="color: red;">未做</b>
													&emsp;
													分值: <b style="color:green;">${esm.subject.subjectScore }</b>
													&emsp;
													难易程度:
													<b style="color:green;">
														<c:if test="${esm.subject.subjectEasy == 0 }">简单</c:if>
														<c:if test="${esm.subject.subjectEasy == 1 }">普通</c:if>
														<c:if test="${esm.subject.subjectEasy == 2 }">困难</c:if>
													</b>
												</p>
											</c:if>
										</div>
									</li>
									<c:set value="${index+1 }" var="index"></c:set>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							 <div class="jumbotron">
								 <h1>暂无试题数据，请联系管理员!</h1>
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
    		//进入测评控制
    		$(".beginExam").click(function() {
    			//获取开始时间
    			var abstractBeginTime = $(this).parent().prev(".beginTime").text();
    			var beginTime = abstractBeginTime.substring(abstractBeginTime.indexOf(":")+2);
    			//获取年月日
    			var date = beginTime.split(" ")[0];
    			var year = date.split("-")[0];
    			var month = parseInt(date.split("-")[1])-1;
    			var day = date.split("-")[2];
				//获取时分秒
				var time = beginTime.split(" ")[1];
				var hour = time.split(":")[0];
				var min = time.split(":")[1];
				var sec = (time.split(":")[2]).split(".")[0];
				//设置开始测评时间对象
				var beginDate = new Date();
				beginDate.setYear(year);
				beginDate.setMonth(month);
				beginDate.setDate(day);
				beginDate.setHours(hour);
				beginDate.setMinutes(min);
				beginDate.setSeconds(sec);
				//当前日期对象
				var nowDate = new Date();
				
				if(nowDate.getTime() < beginDate.getTime()) {
					zeroModal.show({
						title: "提示",
						content: "测评暂未开始, 请耐心等待!",
						width : '200px',
						height : '130px',
						overlay : true,
						ok : true,
						onClosed : function() {
							location.reload();
						}
					});
	    			return false;
				}
    		});
    	});
    </script>
</body>
</html>