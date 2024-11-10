<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>测评</title>
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
 			width:35px; height: 35px; float: left; background-color: green; margin-left: 10px; margin-top: 3px; color: #FFF; font-size: 14px; text-align: center;
 			line-height: 35px; cursor: pointer;
 			border-radius: 3px;
 		}
 		.aswer-p {
 			width: 100%;
 			height: 30px;
 			line-height: 30px;
			cursor: pointer;
 		}
 		.aswer-p:hover {
 			background-color: #FFF;
 		}
 		input {
		}
		.subjectOption {
			padding-top: 0px;
		}
		.hidden_info {
			display: none;
		}
 	</style>
</head>
<body style="background-color: #F4F4F4;">
	<div class="container" style="margin-top: 150px;">
		<!-- 试题 -->
		<div style="width: 60%; height: 100%; float: left;">
			<div style="width: 100%; height: 80%;">
				<dl subject="1" style="width:100%;">
					<span style="display: none;" id="exam-studentId">${sessionScope.loginStudent.studentId }</span>
					<span id="sumSubject" style="display: none;">${sumSubject }</span>
					<c:if test="${esms != null }">
						<c:set value="1" var="index"></c:set>
						<c:forEach items="${esms }" var="esm">
								<dd style="float: left;display: none; width: 100%;" index="${index }" id="${esm.subject.subjectId }">
									<div>
										<p>${index }、${esm.subject.subjectName }</p>
									</div>
									<div>
										<%-- 单选 --%>
										<c:if test="${esm.subject.subjectType == 0 }">
											<p class="aswer-p"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-A" type="radio" name="chooseRight-${esm.subject.subjectId }" value="A"/>&nbsp;<span class="subjectOption">${esm.subject.optionA }</span></p>
											<p class="aswer-p"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-B" type="radio" name="chooseRight-${esm.subject.subjectId }" value="B"/>&nbsp;<span class="subjectOption">${esm.subject.optionB }</span></p>
											<p class="aswer-p"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-C" type="radio" name="chooseRight-${esm.subject.subjectId }" value="C"/>&nbsp;<span class="subjectOption">${esm.subject.optionC }</span></p>
											<p class="aswer-p"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-D" type="radio" name="chooseRight-${esm.subject.subjectId }" value="D"/>&nbsp;<span class="subjectOption">${esm.subject.optionD }</span></p>
										</c:if>
										<%-- 多选 --%>
										<c:if test="${esm.subject.subjectType == 1 }">
											<p class="aswer-p subject-id-${esm.subject.subjectId }" data-sid="${esm.subject.subjectId }" data-type="checkbox" data-val="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-A" type="checkbox" name="chooseRight-${esm.subject.subjectId }" value="A"/>&nbsp;<span class="subjectOption">${esm.subject.optionA }</span></p>
											<p class="aswer-p subject-id-${esm.subject.subjectId }" data-sid="${esm.subject.subjectId }" data-type="checkbox" data-val="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-B" type="checkbox" name="chooseRight-${esm.subject.subjectId }" value="B"/>&nbsp;<span class="subjectOption">${esm.subject.optionB }</span></p>
											<p class="aswer-p subject-id-${esm.subject.subjectId }" data-sid="${esm.subject.subjectId }" data-type="checkbox" data-val="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-C" type="checkbox" name="chooseRight-${esm.subject.subjectId }" value="C"/>&nbsp;<span class="subjectOption">${esm.subject.optionC }</span></p>
											<p class="aswer-p subject-id-${esm.subject.subjectId }" data-sid="${esm.subject.subjectId }" data-type="checkbox" data-val="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-"><input class="aswer-option" id="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-D" type="checkbox" name="chooseRight-${esm.subject.subjectId }" value="D"/>&nbsp;<span class="subjectOption">${esm.subject.optionD }</span></p>
										</c:if>
										<%-- 简答题 --%>
										<c:if test="${esm.subject.subjectType == 2 }">
										<p class="aswer-p subject-id-${esm.subject.subjectId }" data-sid="${esm.subject.subjectId }" data-type="textarea" data-val="${esm.examPaper.examPaperId }-${esm.subject.subjectId }-${index }-"><textarea class="aswer-textarea" name="chooseRight-${esm.subject.subjectId }" style="width:100%;height:100px;" onblur="textareaSubmit(this)"></textarea></p>
										</c:if>
									</div>
									<%--获取 记录已选的试题信息 --%>
									<c:if test="${chooses != null }">
										<c:forEach items="${chooses }" var="choose">
											<c:if test="${choose.subject.subjectId == esm.subject.subjectId }">
												<c:if test="${esm.subject.subjectType == 0 }">
												<span style="display: none;" class="temp-subjectId">${choose.subject.subjectId },</span>
												<span style="display: none;" class="temp-result">${choose.chooseResult },</span>
												</c:if>
												<c:if test="${esm.subject.subjectType == 1 }">
												<span style="display: none;" class="temp-checkbox-subjectId">${choose.subject.subjectId }</span>
												<span style="display: none;" class="temp-checkbox--result">${choose.chooseResult }</span>
												</c:if>
												<c:if test="${esm.subject.subjectType == 2 }">
												<span style="display: none;" class="temp-textarea-subjectId">${choose.subject.subjectId }</span>
												<span style="display: none;" class="temp-textarea--result">${choose.chooseResult }</span>
												</c:if>
											</c:if>
										</c:forEach>
									</c:if>
								</dd>
								<c:set value="${index+1 }" var="index"></c:set>
						</c:forEach>
					</c:if>
				</dl>
			</div>
			<div style="width:100%; height:20%; margin-top: 170px;">
				<button style="float: left;" id="preSubject" type="button" class="btn btn-default btn-lg">上一题</button>
				<button style="float: left;margin-left: 10px;" id="nextSubject" type="button" class="btn btn-default btn-lg">下一题</button>
			</div>
		</div>
		<span id="examEndRefresh_classId" class="hidden_info">${classId }</span>
		<span id="examEndRefresh_gradeId" class="hidden_info">${gradeId }</span>
		
		<!-- 答题卡 -->
		<span id="beginTime" style="display: none;">${beginTime }</span>
		<span id="examTime" style="display: none;">${examTime }</span>
		<div style="width: 38%; float: right;margin-top: -61px;">
			<div style="width:100%; height:63px;text-align: center;">
				<div style="float: left; width: 42%;height: 100%;">
					<h2>答题卡</h2>
				</div>
				<div style="float: right; width: 55%;height: 100%;line-height: 63px; text-align: left;">
					<a href="submit?studentId=${sessionScope.loginStudent.studentId }&examPaperId=${examPaperId }&classId=${classId }&gradeId=${gradeId }" type="button" class="btn btn-default btn-sm" onclick="return confirm('确定提交吗?')">提交</a>
					<%--隐藏表单，用于测评结束且考生未手动提交试卷 自动提交 --%>
					<form action="submit"method="post" style="display: none;">
						<input type="hidden" value="${sessionScope.loginStudent.studentId }" name="studentId" />
						<input type="hidden" value="${examPaperId }" name="examPaperId" />
						<input type="hidden" value="${classId }" name="classId" />
						<input type="hidden" value="${gradeId }" name="gradeId" />
					</form>
					<span style="font-weight: 600;">剩余时间：
						<span id="lastTime" style="color: #00A06B;font-size: 16px;font-weight: 900;">
							<span id="time_min">${examTime }</span>"
							<span id="time_sec">00</span>'
						</span>
					</span>
				</div>
			</div>
			<div style="width: 100%; height: 100%;margin-top: 10px;">
				<ul>
					<c:if test="${esms != null }">
						<c:set value="1" var="indexAswer"></c:set>
						<c:forEach items="${esms }" var="esm">
								<c:if test="${indexAswer == 1 }">
									<li style="background-color: red;">
										${indexAswer }
									</li>
								</c:if>
								<c:if test="${indexAswer != 1 }">
									<li>
										${indexAswer }
									</li>
								</c:if>
								<c:set value="${indexAswer+1 }" var="indexAswer"></c:set>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script src="${path }/js/login.js"></script>
    <script src="${path }/js/exam.js"></script>
    <script type="text/javascript">
    	$(function() {
    		//将已选单选试题对应题号变为已选状态
    		var temp_subjectIds = $(".temp-subjectId").text();
    		var temp_results = $(".temp-result").text();
			var subjectArr = temp_subjectIds.split(",");
			var resultArr = temp_results.split(",");
    		for(var i=0; i<subjectArr.length-1; i++) {
    			$(".aswer-option[name=chooseRight-"+subjectArr[i]+"][value="+resultArr[i]+"]").attr("checked", "checked");
    		}
    		
    		//将已选多选试题对应题号变为已选状态
    		$(".temp-checkbox-subjectId").each(function(i,e){
    			var rst = $(e).next("span.temp-checkbox--result").text();
    			var rstArr = rst.split(",");
    			for(var i=0;i<rstArr.length;i++){
    				$(".aswer-option[name=chooseRight-"+$(e).text()+"][value="+rstArr[i]+"]").attr("checked", "checked");
    			}
    		});
    		
    		//将已做简答试题对应题号变为已选状态
    		$(".temp-textarea-subjectId").each(function(i,e){
    			var rst = $(e).next("span.temp-textarea--result").text();
    			$(".aswer-textarea[name=chooseRight-"+$(e).text()+"]").val(rst);
    		});
    		
    		//加载已选试题对应答题卡信息
    		for(var i=0; i<$("li").size(); i++) {
    			for(var j=0; j<4; j++) {
    				//如果是简答
    				if($("dd").eq(i).children("div").eq(1).children("p").eq(j).attr('data-type') == 'textarea'){
    					var e = $("dd").eq(i).children("div").eq(1).children("p").eq(j).children("textarea");
    					if($(e).val() != ''){
    						$("li").eq(i).css("background-color", "orange");
    					}
    					break;
    				}
    				if($("dd").eq(i).children("div").eq(1).children("p").eq(j).children("input").get(0).checked) {
    					$("li").eq(i).css("background-color", "orange");
    					break;
    				}
    			}
    		}
    		$("li").first().css("background-color", "red");
    	});
    </script>
</body>
</html>