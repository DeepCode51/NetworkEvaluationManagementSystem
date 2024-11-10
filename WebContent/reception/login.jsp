<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>登录</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<div>
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizonta form-signinl" onsubmit="return receptionLoginValidate()" role="form" action="../studentLogin" method="post" id="receptionLogin" name="receptionLogin">
						<div class="form-group">
							 <label for="inputEmail3" class="col-sm-2 control-label">账&emsp;号</label>
							<div class="col-sm-10">
								<input class="form-control" name="studentAccount" id="inputEmail3" type="text" placeholder="测评登录账号" />
								<label style="color: red; font-size: 12px;" id="studentAccountMsg"></label>
							</div>
						</div>
						<div class="form-group">
							 <label for="inputPassword3" class="col-sm-2 control-label">密&emsp;码</label>
							<div class="col-sm-10">
								<input class="form-control" name="studentPwd" id="inputPassword3" type="password" placeholder="测评登录密码" />
								<label style="color: red; font-size: 12px;" id="studentPwdMsg"></label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="checkbox">
									 <label><input type="checkbox" name="remember" />记住我</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								 <button type="submit" class="btn btn-default btn-lg btn-primary btn-block" id="sutdentSignIn">登 录</button>
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
    <script src="${path }/js/login.js"></script>
</body>
</html>