<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>试题信息</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
</head>
<body>
	<!-- 试卷编号(针对手动添加试题到试卷) -->
	<span style="display: none;" id="examPaperId">${examPaperId }</span>
	<div style="text-align: center;">
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<c:if test="${handAdd != null }">
						<th>
							已选:
							<span id="choosed" style="color: red;">${choosed }</span>
						</th>
					</c:if>
					<th>试题编号</th>
					<th>题目</th>
					<th>选项A</th>
					<th>选项B</th>
					<th>选项C</th>
					<th>选项D</th>
					<th>正确答案</th>
					<th>分值</th>
					<th>试题类型</th>
					<th>难易程度</th>
					<th>所属科目</th>
					<th>所属部门</th>
					<c:if test="${handAdd == null }">
						<th>操作
							&emsp;
							<button type="button" class="btn btn-xs btn-info" onclick="subjectAdd()">添加</button>
						</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty subjects }">
						<c:forEach items="${subjects }" var="subject">
							<tr id="tr-${subject.subjectId }">
								<c:if test="${handAdd != null }">
									<td>
										<input type="checkbox" name="chooseSubject" id="${subject.subjectId }" />
									</td>
								</c:if>
								<td>${subject.subjectId }</td>
								<td>
									<c:if test="${fn:length(subject.subjectName) > 8 }">
										${fn:substring(subject.subjectName, 0, 8) }
										<a href="#" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">[...]</a>
									</c:if>
									<c:if test="${fn:length(subject.subjectName) <= 8 }">
										${subject.subjectName }
									</c:if>
								</td>
								<td>
									<c:if test="${fn:length(subject.optionA) > 5 }"> ${fn:substring(subject.optionA, 0, 5) } <sub><a href="#" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">[...]</a></sub> </c:if>
									<c:if test="${fn:length(subject.optionA) <= 5 }"> ${subject.optionA }</c:if>
								</td>
								<td>
									<c:if test="${fn:length(subject.optionB) > 5 }"> ${fn:substring(subject.optionB, 0, 5) } <sub><a href="#" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">[...]</a></sub> </c:if>
									<c:if test="${fn:length(subject.optionB) <= 5 }"> ${subject.optionB }</c:if>
								</td>
								<td>
									<c:if test="${fn:length(subject.optionC) > 5 }"> ${fn:substring(subject.optionC, 0, 5) } <sub><a href="#" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">[...]</a></sub> </c:if>
									<c:if test="${fn:length(subject.optionC) <= 5 }"> ${subject.optionC }</c:if>
								</td>
								<td>
									<c:if test="${fn:length(subject.optionD) > 5 }"> ${fn:substring(subject.optionD, 0, 5) } <sub><a href="#" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">[...]</a></sub> </c:if>
									<c:if test="${fn:length(subject.optionD) <= 5 }"> ${subject.optionD }</c:if>
								</td>
								<td>${subject.rightResult }</td>
								<td id="subjectScore">${subject.subjectScore }</td>
								<td>
									<c:if test="${subject.subjectType == 0 }">单选</c:if>
									<c:if test="${subject.subjectType == 1 }">多选</c:if>
									<c:if test="${subject.subjectType == 2 }">简答</c:if>
								</td>
								<td>
									<c:if test="${subject.subjectEasy == 0 }">简单</c:if>
									<c:if test="${subject.subjectEasy == 1 }">普通</c:if>
									<c:if test="${subject.subjectEasy == 2 }">困难</c:if>
								</td>
								<td>${subject.course.courseName }</td>
								<td>${subject.grade.gradeName }</td>
								<td>
									<c:if test="${handAdd == null }">
										<div class="btn-group">
											<button type="button" class="btn btn-info btn-sm" onclick="_iframe(1,'subject/${subject.subjectId }', 'subjects')">修改</button>
											<button type="button" class="btn btn-danger btn-sm delSubject" id="${subject.subjectId }">删除</button>
										</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</tbody>
		</table>
		<form action="class" method="post">
			<input type="hidden" value="DELETE" name="_method" />
		</form>
		<div>
			<ul class="pagination">
				<li>
					<c:if test="${handAdd != null }">
						<button id="isAddHandle" type="button" class="btn btn-default">添加</button>
					</c:if>
				</li>
				<!-- 
					分页中，需要将 handAdd(是否为手动添加)、examPaperId(试卷编号) 一直传递，以保持查询条件
				 --> 
				
				<li><a href="subjects?startPage=1&handAdd=${handAdd }&examPaperId=${examPaperId }">首页</a></li>
				<c:if test="${pageNow-1 > 0 }">
					<li><a href="subjects?startPage=${pageNow-1 }&handAdd=${handAdd }&examPaperId=${examPaperId }">上一页</a></li>
				</c:if>
				<c:forEach begin="${pageNow }" end="${pageNow+4 }" var="subPage">
					<c:if test="${subPage-5 > 0 }">
						<li><a href="subjects?startPage=${subPage-5 }&handAdd=${handAdd }&examPaperId=${examPaperId }">${subPage-5 }</a></li>
					</c:if>
				</c:forEach>
				<c:forEach begin="${pageNow }" end="${pageNow+5 }" step="1" var="pageNo">
					<!-- 当前页码小于总页数才能显示 -->
					<c:if test="${pageNo <= pageTotal }">
						<c:if test="${pageNow == pageNo }">
							<li class="active"><a href="subjects?startPage=${pageNo }&handAdd=${handAdd }&examPaperId=${examPaperId }">${pageNo }</a></li>
						</c:if>
						<c:if test="${pageNow != pageNo }">
							<li><a href="subjects?startPage=${pageNo }&handAdd=${handAdd }&examPaperId=${examPaperId }" class="pageLink">${pageNo }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${pageNow+1 <= pageTotal }">
					<li><a href="subjects?startPage=${pageNow+1 }&handAdd=${handAdd }&examPaperId=${examPaperId }">下一页</a></li>
				</c:if>
				<li><a href="subjects?startPage=${pageTotal }&handAdd=${handAdd }&examPaperId=${examPaperId }">尾页</a></li>
				<li>
					<a>${pageNow }/${pageTotal }</a>
				</li>
				<li>
					<div style="width:-1%; height:100%;float:right;">
						<form action="subjects" id="scannerPageForm">
							<input id="scannerPage" type="text" name="startPage" handAdd="${handAdd }" examPaperId="${examPaperId }" style="width: 40px; height: 30px; border: 1px solid gray; border-radius: 4px;" />
							<input class="btn btn-default goPage" type="submit" value="Go" style="margin-left: -4px; height: 30px;" />
						</form>
					</div>
				</li>
			</ul>
		</div>
	</div>


	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/kindeditor/kindeditor-min.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
    <script src="${path }/js/zeroModal/zeroModal.min.js"></script>
   	<script src="${path }/js/add-update.js"></script>
   	<script src="${path }/js/handle.js"></script>
   	<script type="text/javascript">
   		function subjectAdd() {
   			zeroModal.show({
   				title : "试题编辑",
   				iframe : true,
   				url : "preAddSubject",
   				width : '90%',
   				height : '90%',
   				cancel : true,
   				top : '0px',
   				left : '0px',
   				esc : true,
   				overlay : true,
   				overlayClose : true,
	  			max: true,
	            min: true,
	            buttons: [{
	                className: 'zeromodal-btn zeromodal-btn-primary',
	                name: '提交',
	                fn: function(opt) {
	                	//获取 iframe中表单数据
	                	var doc = $("iframe").get(0).contentWindow.document.getElementById("radio-form");
	                	//var textAreas = $(doc).children("textarea");
	                	
	                	//alert($(doc).serialize());
	                	//提交
	                	$.ajax({
	                		type : "POST",
	                		data : $(doc).serialize(),
	                		url : "addSubject",
	                		success : function() {
			                	zeroModal.show({
			        				title : "操作成功",
			        				content : "数据提交成功!",
			        				width : '200px',
			        				height : '130px',
			        				overlay : false,
			        				ok : true,
			        				okFn:function(){
										window.location.reload();
									}
			        			});
	                		}
	                	});
	                    return false;
	                }
	            }, {
	                className: 'zeromodal-btn zeromodal-btn-default',
	                name: '退出',
	                fn: function(opt) {
	                	zeroModal.confirm({
	                		content : "您确定退出吗？",
	                		okFn : function() {
	                			zeroModal.closeAll();
	                			return true;
	                		}
	                	});

	                	return false;
	                }
	            }]
   			});
   		}
   		
   		$(function() {
   			//异步删除试题
  			$(".delSubject").click(function() {
  				var subjectId = $(this).attr("id");
  				$.ajax({
  					type: "POST",
  					data: "subjectId="+subjectId,
  					url: "delSubject",
  					success: function(data) {
  						if(data == 't') {
  							$("#tr-"+subjectId).remove();
  						} else {
  							alert("删除失败, 未知异常!");
  						}
  					},
  					error: function() {
						alert("删除失败, 未知异常!");  						
  					}
  				});
  			});
   		});
   	</script>
</body>
</html>