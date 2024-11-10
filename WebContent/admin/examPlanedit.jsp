<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>待考信息编辑</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<link type="text/css" rel="stylesheet" href="${path}/js/jeDate/test/jeDate-test.css" />
    <link type="text/css" rel="stylesheet" href="${path}/js/jeDate/skin/jedate.css" />
    <link href="${path }/js/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<style type="text/css">
 		.dropdown-toggle {
 			height: 30px;
 		}
 	</style>
</head>
<body>	
	<div>
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form" id="examPlanAction" action="examPlan" method="post">
						<c:if test="${examPlan.examPlanId != null }">
							<div class="form-group">
								 <label for="examPlanId" class="col-sm-2 control-label">记录编号</label>
								 <div class="col-sm-3">
								 	<input class="form-control" id="examPlanId" name="examPlanId" type="text" value="${examPlan.examPlanId }" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								 </div>
								 	<input type="hidden" value="PUT" name="_method" />
							</div>
						</c:if>
						<div class="form-group">
							 <label for="classId" class="col-sm-2 control-label">测评部门</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="clazz.classId" id="classId" data-live-search="true">
										<c:if test="${examPlan != null }">
											<option value="${examPlan.clazz.classId }" style="display: none;">${examPlan.clazz.className }</option>
										</c:if>
										<c:forEach items="${classes }" var="clazz">
											<option value="${clazz.classId }">${clazz.className }</option>
										</c:forEach>	
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="courseId" class="col-sm-2 control-label">科目</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="course.courseId" id="courseId" data-live-search="true">
										<c:if test="${examPlan != null }">
											<option value="${examPlan.course.courseId }" style="display: none;">${examPlan.course.courseName }</option>
										</c:if>
										<c:forEach items="${courses }" var="course">
											<option value="${course.courseId }">${course.courseName }</option>
										</c:forEach>	
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="examPaperId" class="col-sm-2 control-label">测评试卷</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="examPaper.examPaperId" id="examPaperId" data-live-search="true">
										<c:if test="${examPlan != null }">
											<option value="${examPlan.examPaper.examPaperId }" style="display: none;">${examPlan.examPaper.examPaperName }</option>
										</c:if>
										<c:forEach items="${examPapers }" var="examPaper">
											<option value="${examPaper.examPaperId }">${examPaper.examPaperName }</option>
										</c:forEach>	
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="beginTime" class="col-sm-2 control-label">开考时间</label>
							<div class="col-sm-5">
								<input class="form-control" id="beginTime" name="beginTime" id="beginTime" value="${examPlan.beginTime }" />
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-4">
								 <button type="submit" class="btn btn-default btn-lg btn-block">
							 		提交
								 </button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script src="${path }/js/add-update.js"></script>
    <script type="text/javascript" src="${path }/js/jeDate/src/jedate.js"></script>
    <script src="${path }/js/bootstrap-select/bootstrap-select.min.js"></script>
    <script type="text/javascript">
    	$(function() {
    		$("input:submit").click(function() {
    			zeroModal.closeAll();
    		});
    		
    		//日期选择
    		jeDate("#beginTime", {
    			isinitVal:true, //显示时间
    			festival:false,  //显示节日
    	        minDate:"2000-01-01",              //最小日期
    	        maxDate:"2020-12-31",              //最大日期
    	        method:{
    	            choose:function (params) {
    	                
    	            }
    	        },
    	        theme:{bgcolor:"#00A680",pnColor:"#00DDAA"},
    	        format: "YYYY-MM-DD hh:mm:ss"
    		});
    		
    		$('.selectpicker').selectpicker({
        	    style: 'btn-default',
        	    size: 8
        	});
    	});
    </script>
</body>
</html>