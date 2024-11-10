<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.taohan.online.exam.service.impl.ExamHistoryPaperServiceImpl"%>
<%@page import="com.taohan.online.exam.po.ExamPlanInfo"%>
<%@page import="com.taohan.online.exam.po.StudentInfo"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>测评中心</title>
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
				<div class="row" id="root-row">
					<c:choose>
						<c:when test="${fn:length(examPlans) > 0 }">
							<c:forEach items="${examPlans }" var="ep">
								<div class="col-md-4">
									<div class="thumbnail">
										<img alt="300x200" src="${pageContext.request.contextPath }/images/reception/peitu1.jpg" />
										<div class="caption">
											<h3>
												${ep.examPaper.examPaperName }
											</h3>
											<p>测评科目: ${ep.course.courseName } &emsp;&emsp; 测评时长: <span id="examPaperTime${ep.examPaper.examPaperId }">${ep.examPaper.examPaperTime }</span> 分钟</p>
											<p>题目数量: ${ep.examPaper.subjectNum } &emsp;&emsp; 总分: ${ep.examPaper.examPaperScore } &emsp;&emsp;
												难易程度: 
												<c:if test="${ep.examPaper.examPaperEasy == 0 }">简单</c:if>
												<c:if test="${ep.examPaper.examPaperEasy == 1 }">普通</c:if>
												<c:if test="${ep.examPaper.examPaperEasy == 2 }">困难</c:if>
											</p>
											<p class="beginTime">开始时间: ${ep.beginTime }</p>
											<p>
												<a class="btn btn-default btn-lg btn-block beginExam" id="${ep.examPaper.examPaperId }" href="begin?classId=${ep.clazz.classId }&examPaperId=${ep.examPaper.examPaperId }&studentId=${sessionScope.loginStudent.studentId }&examTime=${ep.examPaper.examPaperTime }&gradeId=${gradeId }&beginTime=${ep.beginTime }">进入测评</a>
											</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							 <div class="jumbotron">
								 <h1>暂无待考信息</h1>
								 <p>请等待HR分配</p>
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
    			//计算结束时间毫秒
    			var examPaperTime = parseInt($("#examPaperTime"+$(this).attr("id")).text()) * 60 * 1000;
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
				if (nowDate.getTime() > (beginDate.getTime()+examPaperTime)) {
					zeroModal.show({
						title: "提示",
						content: "过期测评记录, 后台即将移除!",
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
    		
    		var divColMd4 = [];
    		var length = $(".row").find("div.col-md-4").length;
    		$("#root-row").find("div.col-md-4").each(function(i,e){
    			if(i > 2){
    				divColMd4.push($(e));
    				$(e).remove();
    			}
    			if(i == length-1){
    				var html = "";
    				var str ='';
    				var k=0;
    				for(;k<divColMd4.length;k++){
    					str +=  divColMd4[k].prop('outerHTML');
    					if((k+1)%3==0 && k!=0){
    						html += '<div class="row">' + str + '</div>';
    						str = '';
    					}
    				}
    				if((k)%3!=0){
    					html += '<div class="row">' + str + '</div>';;
    				}
    				$("#root-row").after(html);
    			}
    		})
    		
    		
    		
    	});
    </script>
</body>
</html>