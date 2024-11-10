<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>科目信息编辑</title>
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
					<form class="form-horizontal" role="form" id="courseAction" action="course" method="post">
						<c:if test="${course.courseId != null }">
							<div class="form-group">
								 <label for="courseId" class="col-sm-2 control-label">学科编号</label>
								 <div class="col-sm-3">
								 	<input class="form-control" id="courseId" name="courseId" type="text" value="${course.courseId }" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								 </div>
								<input type="hidden" value="1" name="isupdate" id="isupdate" />
							</div>
						</c:if>
						<div class="form-group">
							 <label for="division" class="col-sm-2 control-label">分类情况</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="division" id="division" data-live-search="true">
										<c:if test="${course.division == null }">
											<option value="0" style="display: none;">--请选择--</option>
										</c:if>
										<option value="${course.division }" style="display: none;">
											<c:if test="${course.division == 0 }">
												暂未分类
											</c:if>
											<c:if test="${course.division == 1 }">
												刑事
											</c:if>
											<c:if test="${course.division == 2 }">
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
							 <label for="gradeId" class="col-sm-2 control-label">所属部门</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="gradeId" id="gradeId" data-live-search="true">
										<c:if test="${course != null }">
											<option value="${course.grade.gradeId }" style="display: none;">
												${course.grade.gradeName }
											</option>
										</c:if>
										<c:if test="${course == null }">
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
							 <label for="courseName" class="col-sm-2 control-label">学科名称</label>
							<div class="col-sm-5">
								<input class="form-control" id="courseName" name="courseName" type="text" value="${course.courseName }" placeholder="学科名称" />
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-4">
								 <button id="sub" uUrl="course" aUrl="course/course" type="button" class="btn btn-default btn-lg btn-block">
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