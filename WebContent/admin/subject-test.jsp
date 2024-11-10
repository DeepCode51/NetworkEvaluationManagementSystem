<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<c:set var="path" value="<%=basePath%>"></c:set>
<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<link href="${path }/js/bootstrap-select/bootstrap-select.min.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${path }/js/zeroModal/zeroModal.css" />
<style type="text/css">
.dropdown-toggle {
	height: 30px;
}

.divOption {
	float: left;
}
</style>
<script type="text/javascript">
function subjectUpdate() {
	
	//提交
	$.ajax({
		type : "POST",
		data : $("form").serialize(),
		url : "../updateSubject",
		success : function(data) {
			zeroModal.show({
				title : "操作成功",
				content : "数据提交成功!",
				width : '200px',
				height : '130px',
				overlay : false,
				ok : true,
				okFn:function(){
					window.top.frames["right"].history.back(-1);
				}
			});
		},
		error : function(data) {
			zeroModal.show({
				title : "操作失败",
				content : "数据提交失败!",
				width : '200px',
				height : '130px',
				overlay : false,
				ok : true,
			});
		}
	});
	return false;
}	
function selectType(e){
	var activeLi = $(e);
	if('单选题' == activeLi.text()){
		$("#subjectType-hidden-value").val(0);
	}
	if('多选题' == activeLi.text()){
		$("#subjectType-hidden-value").val(1);
	}
	if('简答题' == activeLi.text()){
		$("#subjectType-hidden-value").val(2);
	}
}
</script>
</head>
<body>

	<form action="subject" id="radio-form">
		<c:if test="${subject != null }">
		<input type="hidden" name="subjectType" id="subjectType-hidden-value" value="${subject.subjectType }" />
		</c:if>
		<c:if test="${subject == null }">
		<input type="hidden" name="subjectType" id="subjectType-hidden-value" value="0" />
		</c:if>
		<ul id="editor-title" class="nav nav-tabs">
			<c:if test="${subject != null }">
			<c:if test="${subject.subjectType == 0 }">
			<li class="active"><a href="#radioSubject" data-toggle="tab" onclick="selectType(this)">单选题</a></li>
			<li><a href="#checkSubject" data-toggle="tab" onclick="selectType(this)">多选题</a></li>
			<li><a href="#answerSubject" data-toggle="tab" onclick="selectType(this)">简答题</a></li>
			</c:if>
			<c:if test="${subject.subjectType == 1 }">
			<li ><a href="#radioSubject" data-toggle="tab" onclick="selectType(this)">单选题</a></li>
			<li class="active"><a href="#checkSubject" data-toggle="tab" onclick="selectType(this)">多选题</a></li>
			<li><a href="#answerSubject" data-toggle="tab" onclick="selectType(this)">简答题</a></li>
			</c:if>
			<c:if test="${subject.subjectType == 2 }">
			<li ><a href="#radioSubject" data-toggle="tab" onclick="selectType(this)">单选题</a></li>
			<li ><a href="#checkSubject" data-toggle="tab" onclick="selectType(this)">多选题</a></li>
			<li class="active"><a href="#answerSubject" data-toggle="tab" onclick="selectType(this)">简答题</a></li>
			</c:if>
			</c:if>
			<c:if test="${subject == null }">
			<li class="active"><a href="#radioSubject" data-toggle="tab" onclick="selectType(this)">单选题</a></li>
			<li><a href="#checkSubject" data-toggle="tab" onclick="selectType(this)">多选题</a></li>
			<li><a href="#answerSubject" data-toggle="tab" onclick="selectType(this)">简答题</a></li>
			</c:if>
		</ul>
		<div id="editor-content" class="tab-content">
			<!-- 单选题 -->
			<c:if test="${subject == null || subject.subjectType == 0 }">
			<div class="tab-pane fade in active" id="radioSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="radioSubject-subject-subjectName"
					style="width: 100%; height: 150px;">${subject.subjectName }</textarea>
				<b>选项A：</b> <input type="radio" name="rightResult" value="A" />A
				<textarea name="optionA" id="radioSubject-subject-optionA"
					style="width: 100%; height: 50px;">${subject.optionA }</textarea>
				<b>选项B：</b> <input type="radio" name="rightResult" value="B" />B
				<textarea name="optionB" id="radioSubject-subject-optionB"
					style="width: 100%; height: 50px;">${subject.optionB }</textarea>
				<b>选项C：</b> <input type="radio" name="rightResult" value="C" />C
				<textarea name="optionC" id="radioSubject-subject-optionC"
					style="width: 100%; height: 50px;">${subject.optionC }</textarea>
				<b>选项D：</b> <input type="radio" name="rightResult" value="D" />D
				<textarea name="optionD" id="radioSubject-subject-optionD"
					style="width: 100%; height: 50px;">${subject.optionD }</textarea>
				<!-- 导入外部其他信息编辑页面 -->
			</div>
			</c:if>
			<c:if test="${subject != null && subject.subjectType != 0}">
			<div class="tab-pane fade" id="radioSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="radioSubject-subject-subjectName"
					style="width: 100%; height: 150px;"></textarea>
				<b>选项A：</b> <input type="radio" name="rightResult" value="A" />A
				<textarea name="optionA" id="radioSubject-subject-optionA"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项B：</b> <input type="radio" name="rightResult" value="B" />B
				<textarea name="optionB" id="radioSubject-subject-optionB"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项C：</b> <input type="radio" name="rightResult" value="C" />C
				<textarea name="optionC" id="radioSubject-subject-optionC"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项D：</b> <input type="radio" name="rightResult" value="D" />D
				<textarea name="optionD" id="radioSubject-subject-optionD"
					style="width: 100%; height: 50px;"></textarea>
				<!-- 导入外部其他信息编辑页面 -->
			</div>
			</c:if>
			<!-- 多选题 -->
			<c:if test="${subject == null || subject.subjectType != 1 }">
			<div class="tab-pane fade" id="checkSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="checkSubject-subject-subjectName"
					style="width: 100%; height: 150px;"></textarea>
				<b>选项A：</b> <input type="checkbox" name="rightResult" value="A" />A
				<textarea id="checkSubject-subject-optionA" name="optionA"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项B：</b> <input type="checkbox" name="rightResult" value="B" />B
				<textarea id="checkSubject-subject-optionB" name="optionB"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项C：</b> <input type="checkbox" name="rightResult" value="C" />C
				<textarea id="checkSubject-subject-optionC" name="optionC"
					style="width: 100%; height: 50px;"></textarea>
				<b>选项D：</b> <input type="checkbox" name="rightResult" value="D" />D
				<textarea id="checkSubject-subject-optionD" name="optionD"
					style="width: 100%; height: 50px;"></textarea>
			</div>
			</c:if>
			<c:if test="${subject != null && subject.subjectType == 1 }">
			<div class="tab-pane fade active in" id="checkSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="checkSubject-subject-subjectName"
					style="width: 100%; height: 150px;">${subject.subjectName }</textarea>
				<b>选项A：</b> <input type="checkbox" name="rightResult" value="A" />A
				<textarea id="checkSubject-subject-optionA" name="optionA"
					style="width: 100%; height: 50px;">${subject.optionA }</textarea>
				<b>选项B：</b> <input type="checkbox" name="rightResult" value="B" />B
				<textarea id="checkSubject-subject-optionB" name="optionB"
					style="width: 100%; height: 50px;">${subject.optionB }</textarea>
				<b>选项C：</b> <input type="checkbox" name="rightResult" value="C" />C
				<textarea id="checkSubject-subject-optionC" name="optionC"
					style="width: 100%; height: 50px;">${subject.optionC }</textarea>
				<b>选项D：</b> <input type="checkbox" name="rightResult" value="D" />D
				<textarea id="checkSubject-subject-optionD" name="optionD"
					style="width: 100%; height: 50px;">${subject.optionD }</textarea>
			</div>
			</c:if>
			<!-- 简答题 -->
			<c:if test="${subject == null || subject.subjectType != 2 }">
			<div class="tab-pane fade" id="answerSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="answerSubject-subject-subjectName"
					style="width: 100%; height: 150px;"></textarea>
				<b>答案：</b>
				<textarea name="rightResult" id="answerSubject-subject-answer"
					style="width: 100%; height: 100px;"></textarea>
			</div>
			</c:if>
			<c:if test="${subject != null && subject.subjectType == 2 }">
			<div class="tab-pane fade active in" id="answerSubject">
				<b>题目：</b>
				<textarea name="subjectName" id="answerSubject-subject-subjectName"
					style="width: 100%; height: 150px;">${subject.subjectName }</textarea>
				<b>答案：</b>
				<textarea name="rightResult" id="answerSubject-subject-answer"
					style="width: 100%; height: 100px;">${subject.rightResult }</textarea>
			</div>
			</c:if>
		</div>
			<div class="container" style="margin-top:10px;">
				<div class="row clearfix">
					<div class="col-md-6 column">
						<div class="form-group">
							<label for="subjectEasy" class="col-sm-5 control-label">难易程度</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="subjectEasy" id="subjectEasy"
									data-live-search="true">
									<c:if test="${subject == null }">
										<option value="0" style="display: none;">简单</option>
									</c:if>
									<c:if test="${subject != null }">
										<option style="display: none;" value="${subject.subjectEasy }">
											<c:if test="${subject.subjectEasy == 0 }">简单</c:if>
											<c:if test="${subject.subjectEasy == 1 }">普通</c:if>
											<c:if test="${subject.subjectEasy == 2 }">困难</c:if>
										</option>
									</c:if>
									<option value="0">简单</option>
									<option value="1">普通</option>
									<option value="2">困难</option>
								</select>
							</div>
						</div>
						</div>
						<div class="col-md-6 column">
						<div class="form-group">
							<label for="division" class="col-sm-5 control-label">分类情况</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="division" id="division"
									data-live-search="true">
									<c:if test="${subject == null }">
									<option value="0" style="display: none;">未分类</option>
									</c:if>
									<c:if test="${subject != null }">
										<option style="display: none;" value="${subject.division }">
											<c:if test="${subject.division == 0 }">未分类</c:if>
											<c:if test="${subject.division == 1 }">刑事</c:if>
											<c:if test="${subject.division == 2 }">民诉</c:if>
										</option>
									</c:if>
									<option value="0">未分类</option>
									<option value="1">刑事</option>
									<option value="2">民诉</option>
								</select>
							</div>
						</div>
						</div>
						<div class="row clearfix" >
						<div class="col-md-6 column" style="margin-top:5px;">
						<div class="form-group">
							<label for="courseId" class="col-sm-5 control-label" style="padding-left: 30px;">所属科目</label>
							<div class="col-sm-5" style="padding-left: 22px;">
								<select class="selectpicker" name="course.courseId"
									id="courseId" data-live-search="true">
									<c:if test="${subject != null }">
											<option value="${subject.course.courseId }" style="display: none;">
												${subject.course.courseName }
											</option>
										</c:if>
									<c:forEach items="${courses }" var="course">
									<option value="${course.courseId }">${course.courseName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</div>
						<div class="col-md-6 column" style="margin-top:5px;">
						<div class="form-group">
							<label for="gradeId" class="col-sm-5 control-label">所属部门</label>
							<div class="col-sm-5" style="padding-left: 8px;">
								<select class="selectpicker" name="grade.gradeId" id="gradeId"
									data-live-search="true">
									<c:if test="${subject != null }">
											<option value="${subject.grade.gradeId }" style="display: none;">
												${subject.grade.gradeName }
											</option>
										</c:if>
									<c:forEach items="${grades }" var="grade">
									<option value="${grade.gradeId }">${grade.gradeName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						</div>
						<div class="row clearfix">
						<div class="col-md-12 column" style="margin-top:5px;">
						<div class="form-group">
							<label for="subjectScore" class="col-sm-5 control-label" style="padding-left: 43px;width:21.5%;">题目分值</label>
							<div class="col-sm-5">
								<input class="form-control" id="subjectScore"
									name="subjectScore" type="text"
									value="${subject.subjectScore }" placeholder="当前题目分值" />
							</div>
						</div>
					</div>
				</div>
				<c:if test="${subject != null }">
				<div class="row clearfix">
						<div class="col-md-12 column" style="margin-top:5px;">
						
							<input type="hidden" value="${subject.subjectId }" name="subjectId" />
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-5" style="padding-left: 43px;width:21.5%;margin-left: 0px;">
									<button id="sub" onclick="subjectUpdate()"
										type="button" class="btn btn-default btn-lg btn-block">
										提交</button>
								</div>
							</div>
						
					</div>
				</div>
				</c:if>
			</div>
		</div>
		</div>
	</form>

	<!-- js引入 -->
	<script src="${path }/js/jquery.js"></script>
	<script src="${path }/js/bootstrap/bootstrap.min.js"></script>
	<script src="${path }/js/bootstrap-select/bootstrap-select.min.js"></script>
	<script src="${path }/js/zeroModal/zeroModal.min.js"></script>
	<script type="text/javascript">
		$('.selectpicker').selectpicker({
			style : 'btn-default',
			size : 8
		});
	</script>
	 <script src="${path }/js/kindeditor/kindeditor-min.js"></script> 
	<!-- 编辑器 -->
	<script type="text/javascript">
		KindEditor
				.ready(function(K) {
					editor = K
							.create(
									"#radioSubject-subject-subjectName, #radioSubject-subject-optionA, #radioSubject-subject-optionB, #radioSubject-subject-optionC, #radioSubject-subject-optionD",
									{
										resizeType : 0,
										allowPreviewEmoticons : false,
										allowImageUpload : true,
										items : [ 'fontname', 'fontsize', '|',
												'forecolor', 'hilitecolor',
												'bold', 'underline', 'italic',
												'|', 'fullscreen' ],
										afterBlur: function () { this.sync(); }
									});
					editor.sync();
					editor = K
							.create(
									"#checkSubject-subject-subjectName, #checkSubject-subject-optionA, #checkSubject-subject-optionB, #checkSubject-subject-optionC, #checkSubject-subject-optionD",
									{
										resizeType : 0,
										allowPreviewEmoticons : false,
										allowImageUpload : true,
										items : [ 'fontname', 'fontsize', '|',
												'forecolor', 'hilitecolor',
												'bold', 'underline', 'italic',
												'|', 'fullscreen' ],
										afterBlur: function () { this.sync(); }
									});
					editor.sync();
					editor = K
							.create(
									"#answerSubject-subject-subjectName, #answerSubject-subject-answer",
									{
										resizeType : 0,
										allowPreviewEmoticons : false,
										allowImageUpload : true,
										items : [ 'fontname', 'fontsize', '|',
												'forecolor', 'hilitecolor',
												'bold', 'underline', 'italic',
												'|', 'fullscreen' ],
										afterBlur: function () { this.sync(); }
									});
					editor.sync();
				});
	</script>
</body>
</html>