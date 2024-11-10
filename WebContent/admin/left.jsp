<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>后台首页功能菜单栏</title>
	<%
    	String path = request.getContextPath();
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    %>
	<c:set var="path" value="<%=basePath %>"></c:set>
 	<link href="${path }/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
 	<link rel="stylesheet" type="text/css" href="${path }/js/zeroModal/zeroModal.css" />
 	<style type="text/css">
		body{margin:0;padding:0;overflow-x:hidden;}
		html, body{height:100%;}
		img{border:none;}
		*{font-family:'微软雅黑';font-size:12px;color:#626262;}
		dl,dt,dd{display:block;margin:0;}
		a{text-decoration:none;}
		a:HOVER{text-decoration: none;}
		a:link{text-decoration:none; }
		a:visited{text-decoration:none; }
		a:active{text-decoration:none;}
		
		#bg{background-image:url(../images/content/dotted.png);}
		.container{width:100%;height:100%;margin:auto;}
		
		/*left*/
		.leftsidebar_box{width:205px;height:auto !important;overflow:visible !important;position:fixed;height:100% !important;background-color:#F9F9F9;margin-left: -15px;border-right: 2px solid #E5E5E5;}
		.line{height:2px;width:100%;background-image:url(../images/left/line_bg.png);background-repeat:repeat-x;}
		.leftsidebar_box dl{border-bottom: 1px solid #E5E5E5; border-color: #FCFCFC -moz-use-text-color #E5E5E5;}
		.leftsidebar_box dt{padding-left:40px;padding-right:10px;background-repeat:no-repeat;background-position:10px center;color:#585858;font-size:14px;position:relative;line-height:48px;cursor:pointer;}
		.leftsidebar_box dd{background-color:#FFFFFF;padding-left:40px;}
		.leftsidebar_box dd a{color:#585858;line-height:20px;font-size: 14px;}
		.leftsidebar_box dt img{position:absolute;right:10px;top:20px;}
		.home dt{background-image:url(../images/left/home.png)}
		.system_log dt{background-image:url(../images/left/system.png)}
		.custom dt{background-image:url(../images/left/p1.png)}
		.channel dt{background-image:url(../images/left/p2.png)}
		.app dt{background-image:url(../images/left/paper.png)}
		.cloud dt{background-image:url(../images/left/subject.png)}
		.syetem_management dt{background-image:url(../images/left/plan.png)}
		.source dt{background-image:url(../images/left/clock.png)}
		.statistics dt{background-image:url(../images/left/statistics.png)}
		.leftsidebar_box dl dd:last-child{padding-bottom:10px;}
	</style>
</head>
<body id="bg">
	<c:set var="power" value="${sessionScope.adminPower }"></c:set>
	
	<div class="container">
		<div class="leftsidebar_box">
			<div class="line"></div>
			<dl class="home">
				<a href="index.jsp" target="_top">
					<dt>系统首页</dt>
				</a>
			</dl>
			<dl class="system_log">
				<dt onClick="changeImage()">基本信息<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../grades" target="right" id="1" class="handle-view">&emsp;部门管理&emsp;&emsp;&emsp;</a></dd>
				<dd><a href="../courses" target="right" id="2" class="handle-view">&emsp;项目管理&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="custom">
				<dt onClick="changeImage()">工作管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd><a href="../classes" target="right" id="3" class="handle-view">&emsp;工作管理&emsp;&emsp;&emsp;</a></dd>
				<dd><a href="${path }/preStudentCount" target="right" id="11" class="handle-view">&emsp;各部门总人数&emsp;&emsp;&emsp;</a></dd>
			</dl>
			
			<dl class="custom">
				<dt onClick="changeImage()">HR管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../teachers" target="right" id="4" class="handle-view">&emsp;所有HR&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="channel">
				<dt>员工管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../students" target="right" id="5" class="handle-view">&emsp;所有员工&emsp;&emsp;&emsp;</a></dd>
				<dd class="first_dd"><a href="${path }/admin/charts/studentExamCount.jsp" target="right" id="12" class="handle-view">&emsp;员工测评信息&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="app">
				<dt onClick="changeImage()">测评试卷管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../examPapers" target="right" id="6" class="handle-view">&emsp;所有测评试卷&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="cloud">
				<dt>测评题管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../subjects" target="right" id="7" class="handle-view">&emsp;所有试题&emsp;&emsp;&emsp;</a></dd>
				<dd class="first_dd"><a href="../initImport" target="right" id="8" class="handle-view">&emsp;导入试题&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="syetem_management">
				<dt>评测安排管理<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../examPlans" target="right" id="9" class="handle-view">&emsp;待测评信息&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
			<dl class="source">
				<dt>以往测评信息<img src="${path }/images/left/select_xl01.png" /></dt>
				<dd class="first_dd"><a href="../historys" target="right" id="10" class="handle-view">&emsp;所有记录&emsp;&emsp;&emsp;</a></dd>
			</dl>
		
		</div>
	</div>
    
    
	<!-- js引入 -->
    <script src="${path }/js/jquery.js"></script>
    <script src="${path }/js/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="${path }/js/bootstrap/dropdown.js"></script>
	<script src="${path }/js/zeroModal/zeroModal.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.dropdown-toggle').dropdown();
        });
        function changeImage(){}
   </script>
   <script type="text/javascript">
	   $(".leftsidebar_box dt").css({"background-color":"#F2F2F2"});
	   $(".leftsidebar_box dt img").attr("src","../images/left/select_xl01.png");
   		$(function() {
   			$(".handle-view").click(function() {
   				var nowId = $(this).attr('id');
   				//获取到头部 iframe 中的div
   				var headDoc = parent.frames['nav'].document.getElementById("head-nav-show");
   				//判断当前点击操作是否已经存在
   				var headDivs = $(headDoc).children();
   				var flag = true;
   				for(var i=0; i<headDivs.length; i++) {
   					var div = headDivs[i];
   					$(div).css("background-color", "#FFF");
   					$(div).attr("show", "f");
   					var divId = $(div).attr("id").substring(2);
   					//当前操作已经存在
   					if(nowId == divId) {
   						$(div).css("background-color", "#CAE5E8");
   						$(div).attr("show", "t");
		  				flag = false;
   					}
   				}
	   			//向头部div中添加模块
  				if(flag) {
		   			if(headDivs.length >= 11) {
		   				$(headDoc).children().first().remove();
		   			}
  					$(headDoc).append("<div show='t' class='index_title' id='it"+nowId+"' style='float: left;background-color: #CAE5E8;'><a href="+$(this).attr('href')+" target='right' style='color: #707070;margin-left:5px;' onclick='changeShow("+$(this).attr('id')+")'>"+$(this).text().trim()+"</a>&emsp;<sup onclick='removeParent("+$(this).attr('id')+")'>×</sup></div>");
  				}
   			});
   			
   			$(".leftsidebar_box dd").hide();
   			$(".leftsidebar_box dt").click(function(){
   				$(".leftsidebar_box dt").css({"background-color":"#F9F9F9"})
   				$(this).css({"background-color": "#E5E5E5"});
   				$(this).parent().find('dd').removeClass("menu_chioce");
   				$(".leftsidebar_box dt img").attr("src","../images/left/select_xl01.png");
   				$(this).parent().find('img').attr("src","../images/left/select_xl.png");
   				$(".menu_chioce").slideUp(); 
   				$(this).parent().find('dd').slideToggle();
   				$(this).parent().find('dd').addClass("menu_chioce");
   			});
   		});
   </script>
</body>
</html>