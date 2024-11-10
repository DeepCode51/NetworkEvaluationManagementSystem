var pwd = "";
var loginTrue = false;

$(function() {
	
	//后台登录用户名验证
	$("#inputEmail").blur(function() {
		var account = $(this).val();
		if(account == null || account.trim() == "") { return; }
		$.post("../validateTeacher", "account="+account, function(data) {
			if(data == "1") {
				$("#inputEmail").val("");
				$(".error-msg").first().css("display", "block");
			} else {
				pwd = data;
				loginTrue = true;
			}
		});
	}).focus(function() {
		$(".error-msg").first().css("display", "none");		
	});
	//后台登录密码验证
	$("#inputPassword").blur(function() {
		var adminPwd = $(this).val();
		if(adminPwd == null || adminPwd.trim() == "") { return; }
		if(adminPwd != pwd) {
			$(this).val("");
			$(".error-msg").eq(1).css("display", "block");
			loginTrue = false;
		} else {
			loginTrue = true;
		}
	}).focus(function() {
		$(".error-msg").eq(1).css("display", "none");
	});
	
	//后台登录提交
	$("#adminLogin").submit(function() {
		if($("input").first().val().trim() == "" || $("input").last().val().trim() == "") {
			return false;
		}
		return;
		if(loginTrue) {
			return true;
		} else {
			alert("登录信息有误!");
			return false;
		}
	});
	
	
	//前台员工登录
	$("#studentLogin").click(function() {
		zeroModal.show({
			title : '登 录',
			iframe : true,
			url : 'reception/login.jsp',
			width : '30%',
			height : '50%',
			top : '100px',
			left : '430px',
			esc : true,
			overlay : true,
			onClosed : function() {
				location.reload();
			}
		});
	});
	$("#inputEmail3").blur(function() {
		var studnetAccount = $(this).val();
		if(studnetAccount.trim() == "" || studnetAccount == null) {
			loginTrue = false;
			$("#studentAccountMsg").text("账号为空");
			return;
		}
		$.post("../validateLoginStudent", "studentAccount="+studnetAccount, function(data) {
			if(data == "n") {
				$("#inputEmail3").val("");
				$("#studentAccountMsg").text("账号不存在");
				loginTrue = false;
			} else {
				pwd = data;
				loginTrue = true;
			}
		});
	}).focus(function() {
		$("#studentAccountMsg").text("");
	});
	$("#inputPassword3").blur(function() {
		var studentPwd = $(this).val();
		if(studentPwd == null || studentPwd.trim() == "") {
			loginTrue = false;
			return;
		}
		return;
		if(studentPwd != pwd) {
			$(this).val("");
			$("#studentPwdMsg").text("密码错误");
			loginTrue = false;
		} else {
			loginTrue = true;
		}
	}).focus(function() {
		$("#studentPwdMsg").text("");
	});
	//前台员工注册
	$("#studentRegister").click(function() {
		zeroModal.show({
			title : '注册',
			iframe : true,
			url : 'preStudentReg',
			width : '28%',
			height : '45%',
			top : '100px',
			left : '430px',
			esc : true,
			overlay : true,
			onClosed : function() {
				location.reload();
			}
		});
	});
	//员工注册账户验证
	$("#account").blur(function() {
		var account = $(this).val();
		if (account == null || account.trim() == "") {
			return false;
		}
		$.ajax({
			type: "POST",
			data: "studentAccount="+account,
			url: "validateAccount",
			success: function(data) {
				if(data.trim() == "f") {
					zeroModal.show({
						title: "提示",
						content: "该账户已被注册!",
						width : '200px',
						height : '130px',
						overlay : false,
						ok : true,
						onClosed : function() {
							$("#account").val("");
						}
					});
					return false;
				}
			}
		});
	});
	//员工注册提交
	$("#signSubmit").click(function() {
		//注册数据有效性验证
		var studentName = $("#validateName").val();
		var studentAccount = $("#account").val();
		var studentPwd = $("#pwd").val();
		var classId = $("#classId").val();
		if(studentName.trim() == null || studentName.trim() == "") {
			zeroModal.show({
				title: "提示",
				content: "请输入真实姓名!",
				width : '200px',
				height : '130px',
				overlay : false,
				ok : true,
				onClosed : function() {
					$("#validateName").val("");
					$("#validateName").get(0).focus();
				}
			});
			return false;
		}
		if(studentAccount.trim() == null || studentAccount.trim() == "" || studentAccount.length <= 0 || studentAccount.length > 30) {
			zeroModal.show({
				title: "提示",
				content: "测评登录账户不合法!",
				width : '200px',
				height : '130px',
				overlay : false,
				ok : true,
				onClosed : function() {
					$("#account").val("");
					$("#account").get(0).focus();
				}
			});
			return false;
		}
		if(studentPwd.trim() == null || studentPwd.trim() == "" || studentPwd.length < 6 || studentPwd.length > 16) {
			zeroModal.show({
				title: "提示",
				content: "测评登录密码不合法!",
				width : '200px',
				height : '130px',
				overlay : false,
				ok : true,
				onClosed : function() {
					$("#pwd").val("");
					$("#pwd").get(0).focus();
				}
			});
			return false;
		}
		$.ajax({
			type: "POST",
			url: "studentReg",
			data: "name="+studentName+"&account="+studentAccount+"&pwd="+studentPwd+"&classId="+classId,
			success: function(data) {
				if (data.trim() == "t") {
					zeroModal.show({
						title: "提示",
						content: "注册成功!",
						width : '200px',
						height : '130px',
						overlay : false,
						ok : true,
						onClosed : function() {
							$("#validateName").val("");
							$("#account").val("");
							$("#pwd").val("");
						}
					});
					setTimeout(function(){
						window.location.href = 'reception/login.jsp';
					},1000);
				} else {
					alert("注册失败");
				}
			}
		});
	});
});

function receptionLoginValidate() {
	var studnetAccount = $("#inputEmail3").val();
	if(studnetAccount.trim() == "" || studnetAccount == null) {
		loginTrue = false;
		$("#studentAccountMsg").text("账号为空");
		return false;
	}
	var studentPwd = $("#inputPassword3").val();
	if(studentPwd == null || studentPwd.trim() == "") {
		loginTrue = false;
		$("#studentPwdMsg").text("密码为空");
		return false;
	}
	
	if(loginTrue) {
		zeroModal.closeAll();
		location.reload();
		return true;
	} else {
		alert("登录信息有误!");
		return false;
	}
}