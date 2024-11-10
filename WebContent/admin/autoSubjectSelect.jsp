<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.taohan.online.exam.service.impl.CourseInfoServiceImpl"%>
<%@page import="com.taohan.online.exam.po.CourseInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>自动生成试题到试卷选项</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<link href="${path }/js/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
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
					<form class="form-horizontal" role="form" action="../autoAddSubject">
						<input type="hidden" value="${param.examPaperId }" name="examPaperId" />
						<div class="form-group">
							 <label for="subjectSum" class="col-sm-2 control-label">试题数量</label>
							<div class="col-sm-10">
								<input class="form-control" name="subjectSum" id="subjectSum" type="text" placeholder="自动生成试题数量" />
							</div>
						</div>
						<div class="form-group">
							<label for="class" class="col-sm-2 control-label">科目</label>
							<div class="col-sm-10">
								<select id="slpk" class="selectpicker" name="courseId" id="courseId" data-live-search="true">
									<option value="">不限</option>
									<option value="1">语文</option>
									<option value="2">数学</option>
									<option value="3">英语</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="grade" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-10">
								<select id="slpk" class="selectpicker" name="gradeId" id="gradeId" data-live-search="true">
									<option value="">不限</option>
									<option value="1">教一</option>
									<option value="2">教二</option>
									<option value="3">教三</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="grade" class="col-sm-2 control-label">难易程度</label>
							<div class="col-sm-10">
								<select id="slpk" class="selectpicker" name="subjectEasy" id="subjectEasy" data-live-search="true">
									<option value="">不限</option>
									<option value="0">简单</option>
									<option value="1">普通</option>
									<option value="2">困难</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								 <button type="button" class="btn btn-default btn-lg" id="handlesubmit">
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
    <script src="${path }/js/bootstrap-select/bootstrap-select.min.js"></script>
    <script type="text/javascript">
    	$(function() {
    		$('.selectpicker').selectpicker({
        	    style: 'btn-default',
        	    size: 8
        	});
    		
    		$("#handlesubmit").click(function() {
    			$.ajax({
    				type : 'POST',
    				data : $('form').serialize(),
    				url : "../autoAddSubject",
    				success : function(t) {
    					zeroModal.show({
    						title : "操作成功",
    						content : "自动添加试题成功!",
    						width : '200px',
    						height : '130px',
    						overlay : false,
    						ok : true
    					});
    				},
    				error : function() {
    					alert("也许没有满足条件的试题, 操作失败!");
    				}
    			});
    		});
    	});
    </script>
</body>
</html>