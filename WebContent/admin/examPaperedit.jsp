<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>试卷信息编辑</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
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
					<form class="form-horizontal" role="form" id="examPaperAction" action="examPaper" method="post">
						<c:if test="${examPaper.examPaperId != null }">
							<div class="form-group">
								 <label for="examPaperId" class="col-sm-2 control-label">试卷编号</label>
								 <div class="col-sm-3">
								 	<input class="form-control" id="examPaperId" name="examPaperId" type="text" value="${examPaper.examPaperId }" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								 </div>
								 	<input type="hidden" value="1" name="isupdate" id="isupdate" class="form-control" />
							</div>
						</c:if>
						<div class="form-group">
							 <label for="division" class="col-sm-2 control-label">分类情况</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="division" id="division" data-live-search="true">
										<c:if test="${examPaper.division == null }">
											<option value="0" style="display: none;">--请选择--</option>
										</c:if>
										<option value="${examPaper.division }" style="display: none;">
											<c:if test="${examPaper.division == 0 }">
												暂未分类
											</c:if>
											<c:if test="${examPaper.division == 1 }">
												刑事
											</c:if>
											<c:if test="${examPaper.division == 2 }">
												民诉
											</c:if>
										</option>
										<option value="0">不分类</option>
										<option value="1">刑事</option>
										<option value="2">民诉</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="examPaperEasy" class="col-sm-2 control-label">难易程度</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="examPaperEasy" id="examPaperEasy" data-live-search="true">
										<c:if test="${examPaper.examPaperEasy == null }">
											<option value="0" style="display: none;">--请选择--</option>
										</c:if>
										<option value="${examPaper.examPaperEasy }" style="display: none;">
											<c:if test="${examPaper.examPaperEasy== 0 }">
												简单
											</c:if>
											<c:if test="${examPaper.examPaperEasy == 1 }">
												普通
											</c:if>
											<c:if test="${examPaper.examPaperEasy == 2 }">
												困难
											</c:if>
										</option>
										<option value="0">简单</option>
										<option value="1">普通</option>
										<option value="2">困难</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="gradeId" class="col-sm-2 control-label">所属部门</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="gradeId" id="gradeId" data-live-search="true">
									<c:if test="${examPaper != null }">
										<option value="${examPaper.grade.gradeId }" style="display: none;">
											${examPaper.grade.gradeName }
										</option>
									</c:if>
									<c:if test="${examPaper == null }">
										<option value="1" style="display: none;">
											--请选择--
										</option>
									</c:if>
									
									<c:forEach items="${grades }" var="grade">
									<option value="${grade.gradeId }">${grade.gradeName }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="examPaperName" class="col-sm-2 control-label">试卷名称</label>
							<div class="col-sm-5">
								<input class="form-control" id="examPaperName" name="examPaperName" type="text" value="${examPaper.examPaperName }" placeholder="试卷名称" />
							</div>
						</div>
						<div class="form-group">
							 <label for="subjectNum" class="col-sm-2 control-label">试题数量</label>
							<div class="col-sm-5">
								<c:if test="${examPaper != null }">
									<input class="form-control" id="subjectNum" name="subjectNum" type="text" value="${examPaper.subjectNum }" placeholder="试卷中的试题总量" />
								</c:if>
								<c:if test="${examPaper == null }">
									<input class="form-control" id="subjectNum" name="subjectNum" type="text" value="0" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								</c:if>
							</div>
						</div>
						<div class="form-group">
							 <label for="examPaperScore" class="col-sm-2 control-label">试卷总分</label>
							<div class="col-sm-5">
								<c:if test="${examPaper != null }">
									<input class="form-control" id="examPaperScore" name="examPaperScore" type="text" value="${examPaper.examPaperScore }" placeholder="试卷总分值" />
								</c:if>
								<c:if test="${examPaper == null }">
									<input class="form-control" id="examPaperScore" name="examPaperScore" type="text" value="0" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								</c:if>
							</div>
						</div>
						<div class="form-group">
							 <label for="examPaperTime" class="col-sm-2 control-label">测评时长</label>
							<div class="col-sm-5">
								<input class="form-control" id="examPaperTime" name="examPaperTime" type="text" value="${examPaper.examPaperTime }" placeholder="当前试卷测评时长" />
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-4">
								 <button id="sub" uUrl="examPaper" aUrl="examPaper/examPaper" type="button" class="btn btn-default btn-lg btn-block">
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
    <script src="${path }/js/bootstrap-select/bootstrap-select.min.js"></script>
    <script type="text/javascript">
    	$('.selectpicker').selectpicker({
    	    style: 'btn-default',
    	    size: 8
    	});
    </script>
</body>
</html>