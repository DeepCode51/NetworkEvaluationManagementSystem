<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>员工信息编辑</title>
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
					<form class="form-horizontal" role="form" id="studentAction" action="student" method="post">
						<c:if test="${student.studentId != null }">
							<div class="form-group">
								 <label for="studentId" class="col-sm-2 control-label">员工编号</label>
								 <div class="col-sm-3">
								 	<input class="form-control" id="studentId" name="studentId" type="text" value="${student.studentId }" readonly="readonly" unselectable='on' onfocus='this.blur()' />
								 </div>
								 	<input type="hidden" value="1" name="isupdate" id="isupdate" class="form-control" />
							</div>
						</c:if>
						<div class="form-group">
							 <label for="classId" class="col-sm-2 control-label">学习部门</label>
							<div class="col-sm-5">
								<select class="selectpicker" name="classId" id="classId" data-live-search="true">
										<option value="${student.classInfo.classId }" style="display: none;">${student.classInfo.className }</option>
										<c:forEach items="${classes }" var="clazz">
											<option value="${clazz.classId }">${clazz.className }</option>
										</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							 <label for="studentName" class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-5">
								<input class="form-control" id="studentName" name="studentName" type="text" value="${student.studentName }" placeholder="员工姓名" />
							</div>
						</div>
						<div class="form-group">
							 <label for="studentAccount" class="col-sm-2 control-label">测评登录账户</label>
							<div class="col-sm-5">
								<input class="form-control" id="studentAccount" name="studentAccount" type="text" value="${student.studentAccount }" placeholder="员工测评登录账户" />
							</div>
						</div>
						<div class="form-group">
							 <label for="studentPwd" class="col-sm-2 control-label">测评登录密码</label>
							<div class="col-sm-5">
								<input class="form-control" id="studentPwd" name="studentPwd" type="password" value="${student.studentPwd }" placeholder="员工测评登录密码" />
							</div>
						</div>
						<br />
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-4">
								 <button id="sub" uUrl="student" aUrl="student/student" type="button" class="btn btn-default btn-lg btn-block">
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