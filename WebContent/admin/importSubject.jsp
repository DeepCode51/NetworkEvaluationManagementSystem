<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>试题导入</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link href="${path }/js/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<style type="text/css">
 		.dropdown-toggle {
 			height: 30px;
 		}
 		#examPaperChoose {
 			display: none;
 		}
 		.importToNewPaper {
 			display: none;
 		}
 		.tips {color: #205AA7;}
 	</style>
</head>
<body>
	<div class="container">
	<div class="row clearfix">
		<div class="col-md-8 column">
			<form class="form-horizontal" role="form" action="dispatcherUpload" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="division" class="col-sm-2 control-label">是否分类</label>
					<div class="col-sm-10">
						<select id="division" class="selectpicker" name="division" id="division" data-live-search="true">
							<option value="0">不分类</option>
							<option value="1">软件</option>
							<option value="2">硬件</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="course" class="col-sm-2 control-label">所属科目</label>
					<div class="col-sm-10">
						<select id="courseId" class="selectpicker" name="courseId" id="course" data-live-search="true">
							<c:if test="${courses != null }">
								<c:forEach items="${courses }" var="course">
									<option value="${course.courseId }">${course.courseName }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="grade" class="col-sm-2 control-label">所属部门</label>
					<div class="col-sm-10">
						<select id="gradeId" class="selectpicker" name="gradeId" id="grade" data-live-search="true">
							<c:if test="${grades != null }">
								<c:forEach items="${grades }" var="grade">
									<option value="${grade.gradeId }">${grade.gradeName }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="importChoose" class="col-sm-2 control-label">选项</label>
					<div class="col-sm-10">
						<label class="radio-inline">
							<input type="radio" name="importOption" id="only-subject" value="0" checked="checked" /> 只导入试题
						</label>
						<label class="radio-inline">
							<input type="radio" name="importOption" id="radio-exists" value="1" /> 导入到已有试卷
						</label>
						<label class="radio-inline">
							<input type="radio" name="importOption" id="radio-new" value="2" /> 导入到新建试卷
						</label>
						<input class="from-control" style="display: none;" />
						<span class="help-block" id="alltips">注意: 导入 Excel 文件中的第一行必须是包含 
						<b class="tips">题目</b>|<b class="tips">答案A-D</b>|<b class="tips">正确答案</b>|<b class="tips">分值</b>|<b class="tips">试题类型</b>|<b class="tips">难易程度</b> 
						与其列对应, 第一行标题名不得有误, 否则将无法解析; 如果是导入到新建试卷, 试卷和试题同用 分类、科目、部门信息。</span>
					</div>
				</div>
				<div class="form-group" id="examPaperChoose">
					<label for="examPaperId" class="col-sm-2 control-label">试卷选择</label>
					<div class="col-sm-10">
						<select class="selectpicker" name="examPaperId" id="examPaperId" data-live-search="true">
							<c:if test="${examPapers != null }">
								<c:forEach items="${examPapers }" var="examPaper">
									<option value="${examPaper.examPaperId }">${examPaper.examPaperName }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				<div class="form-group importToNewPaper">
					<label for="examPaperEasy" class="col-sm-2 control-label">难易程度</label>
					<div class="col-sm-10">
						<select class="selectpicker" name="examPaperEasy" id="examPaperEasy" data-live-search="true">
							<option value="0">简单</option>
							<option value="1">普通</option>
							<option value="2">困难</option>
						</select>
					</div>
				</div>
				<div class="form-group importToNewPaper">
					 <label for="examPaperName" class="col-sm-2 control-label">试卷名称</label>
					<div class="col-sm-10">
						<input class="form-control" name="examPaperName" id="examPaperName" type="text" placeholder="新建试卷名称" />
					</div>
				</div>
				<div class="form-group importToNewPaper">
					 <label for="examPaperTime" class="col-sm-2 control-label">测评时长</label>
					<div class="col-sm-10">
						<input class="form-control" name="examPaperTime" id="examPaperTime" type="text" placeholder="新建试卷测评时长" />
					</div>
				</div>
				<div class="form-group">
					<label for="inputfile" class="col-sm-2 control-label">选择文件</label>
					<div class="col-sm-10">
						<input class="" name="inputfile" id="inputfile" type="file" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button type="submit" class="btn btn-default">提交</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-4 column">
		</div>
	</div>
</div>

	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
     <script src="${path }/js/bootstrap-select/bootstrap-select.min.js"></script>
     <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script type="text/javascript">
    	$('.selectpicker').selectpicker({
    	    style: 'btn-default',
    	    size: 8
    	});
    	$(function() {
    		$("#alltips").css("font-size", "12px");
    		$("#only-subject").click(function() {
    			$("#examPaperChoose").hide();
    			$(".importToNewPaper").hide();
    		});
    		$("#radio-exists").click(function() {
    			$("#examPaperChoose").show("slow");
    			$(".importToNewPaper").hide();
    		});
    		$("#radio-new").click(function() {
    			$("#examPaperChoose").hide();
    			$(".importToNewPaper").show("slow");
    		});
    	});
    </script>
</body>
</html>