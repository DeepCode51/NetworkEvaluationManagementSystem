var lastTimeTimer;
$(function() {

	$("dd").first().css("display", "block");
	
	$("#preSubject").click(function() {
		var nowShow = parseInt($("dl").attr("subject"));
		
		if((nowShow-1) < 1) {
			return;
		}
		
		$("dd[index="+nowShow+"]").css("display", "none");
		$("dd[index="+(nowShow-1)+"]").css("display", "block");
		
		$("li").css("background-color", "green");
		hasChooseHandler();
		$("li").eq(nowShow-2).css("background-color", "red");
		

		$("dl").attr("subject", nowShow-1);
	});

	$("#nextSubject").click(function() {
		var nowShow = parseInt($("dl").attr("subject"));

		var lastSubject = parseInt($("#sumSubject").text());
		if((nowShow+1) > lastSubject) {
			return;
		}
		
		$("dd[index="+nowShow+"]").css("display", "none");
		$("dd[index="+(nowShow+1)+"]").css("display", "block");
		
		
		$("li").css("background-color", "green");
		hasChooseHandler();
		$("li").eq(nowShow).css("background-color", "red");
		
		$("dl").attr("subject", nowShow+1);
	});

	$("li").click(function() {
		$("li").css("background-color", "green");
		hasChooseHandler();
		$(this).css("background-color", "red");
		
		var nowShow = parseInt($("dl").attr("subject"));
		var jumpIndex = parseInt($(this).text());
		
		$("dd[index="+nowShow+"]").css("display", "none");
		$("dd[index="+(jumpIndex)+"]").css("display", "block");
		
		
		$("dl").attr("subject", jumpIndex);
	});

	$(".aswer-p").click(function() {
		if($(this).attr('data-type') == 'checkbox'){
			//多选题
			
			var sbid = $(this).attr('data-sid');
			var chid = $(this).attr('data-val');
			$(".subject-id-"+sbid).each(function(i,e){
				var checkboxOption = $($(e).children("input[type='checkbox']").get(0));
				if(checkboxOption.prop("checked")) {
					chid += checkboxOption.val() + ',';
				}
			});
			if(chid != $(this).attr('data-val')){
				//表示有已经选择的
				chid = chid.substring(0,chid.length-1);
				chooseHandler(chid);
				return;
			}
			return;
		}
		//简答题
		if($(this).attr('data-type') == 'textarea'){
			return;
		}
		if(!$(this).children("input").get(0).checked) {
			$(this).children("input").get(0).checked = "checked";
		}
		var chooseId = $(this).children("input").attr("id");
		chooseHandler(chooseId);
	});
	
	$(".aswer-option").change(function() {
		var chooseId = $(this).attr("id");
		//chooseHandler(chooseId);
	});
	
	/*-----------------初始化倒计时 BEGIN-------------------------------*/
	var beginTime = $("#beginTime").text();
	var examTime = parseInt($("#examTime").text()); //剩余分钟数, 这个是测评时长
	
	//获取年月日
	var date = beginTime.split(" ")[0];
	var year = date.split("-")[0];
	var month = parseInt(date.split("-")[1])-1;
	var day = date.split("-")[2];

	//获取时分秒
	var time = beginTime.split(" ")[1];
	var hour = time.split(":")[0];
	var min = time.split(":")[1];
	var sec = (time.split(":")[2]).split(".")[0];

	//设置开始测评时间对象
	var beginDate = new Date();
	beginDate.setYear(year);
	beginDate.setMonth(month);
	beginDate.setDate(day);
	beginDate.setHours(hour);
	beginDate.setMinutes(min);
	beginDate.setSeconds(sec);
	
	//获取当前时间对象
	var nowDate = new Date();
	
	//计算测评时长的秒数
	var examTime_sec = examTime * 60 * 1000;
	//计算结束时间 对应的秒数
	var examEndTime_sec = beginDate.getTime() + examTime_sec;
	
	//获取当前时间对应的秒数
	var nowDate_sec = nowDate.getTime();
	
	//获取时间差 秒
	var subTime_sec = examEndTime_sec - nowDate_sec;
	
	//将时间差 秒 计算为分钟数
	if(subTime_sec > 60*1000) {
		//获取分钟数
		$("#time_min").text(parseInt(subTime_sec/(1000*60)));
		$("#time_sec").text(subTime_sec%(1000*60)/1000);
	} else {
		$("#time_sec").text(subTime_sec%(1000*60)/1000);
		$("#time_min").text(0);			
	}
	/*-----------------初始化倒计时 END-------------------------------*/
	
	//测评计时
	lastTimeTimer = setInterval("subTime()", 1000);
});

//选择答案处理
function chooseHandler(chooseId) {
	var studentId = $("#exam-studentId").text();
	var args = chooseId.split("-");
	var examPaperId = args[0];
	var subjectId = args[1];
	var index = args[2];
	var chooseAswer = args[3];
	
	$.ajax({
		type: "POST",
		data: "studentId="+studentId+"&examPaperId="+examPaperId+"&subjectId="+subjectId+"&index="+index+"&chooseAswer="+chooseAswer,
		url: "choose",
		success: function(data) {
			if(data.trim()=="f") {
				alert("提交失败，未知异常");
			}
		},
		error: function(data) {
			alert(data);
		}
	});
}

//让已经选择的试题 对应的答题卡 单元格保持已选状态
function hasChooseHandler() {
	for(var i=0; i<$("li").size(); i++) {
		for(var j=0; j<4; j++) {
			
			//如果是多选
			if($("dd").eq(i).children("div").eq(1).children("p").eq(j).attr('data-type') == 'checkbox'){
				var checkboxOption = $($("dd").eq(i).children("div").eq(1).children("p").eq(j).children("input[type='checkbox']").get(0));
				if(checkboxOption.prop('checked')){
					$("li").eq(i).css("background-color", "orange");
					break;
				}
				continue;
			}
			//如果是简答
			if($("dd").eq(i).children("div").eq(1).children("p").eq(j).attr('data-type') == 'textarea'){
				var checkboxOption = $($("dd").eq(i).children("div").eq(1).children("p").eq(j).children("textarea"));
				if(checkboxOption.val() != ''){
					$("li").eq(i).css("background-color", "orange");
				}
				break;
			}
			
			if($("dd").eq(i).children("div").eq(1).children("p").eq(j).children("input").get(0).checked) {
				$("li").eq(i).css("background-color", "orange");
				break;
			}
		}
	}
}

//测评倒计时
function subTime() {
	var lastmin = parseInt($("#time_min").text());
	var lastsec = parseInt($("#time_sec").text());
	
	if(lastmin<=0 && lastsec<=1) {
		//自动提交试卷
		$("form").submit();
		clearInterval(lastTimeTimer);
		zeroModal.show({
			title: "提示",
			content: "测评结束!",
			width : '200px',
			height : '130px',
			overlay : true,
			ok : true,
			onClosed : function() {
				//测评结束回到测评中心页面
				location.href = "willexams?classId="+$('#examEndRefresh_classId').text().trim()+"&gradeId="+$('#examEndRefresh_gradeId').text().trim()+"&studentId="+$('#exam-studentId').text().trim()+"";
			}
		});
		return false;
	}
	
	
	if(lastmin<=3||lastmin-1<=3) {
		$("#lastTime").css("color", "red");
	}
	
	if(lastsec-1 < 0) {
		$("#time_min").text(lastmin-1);
		$("#time_sec").text(59);
		return;
	}
	
	$("#time_sec").text(lastsec-1);
	
}
//简答题提交
function textareaSubmit(e){
	var $this = $(e);
	if($this.val() == '')return;
	var answer = $this.parent("p").attr('data-val') + $this.val();
	//alert(answer);
	chooseHandler(answer);
}