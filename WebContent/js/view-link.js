/*-----------用于通过一个id动态加载其下的数据---------------*/

$(function() {
	
	/*--------------------------部门列表查看当前部门下的部门  BEGIN---------------------------*/
	var lastclick_class = -1;
	$(".lookclass").click(function() {
		//添加之前先清空之前样式
		$(this).parent().parent().parent().siblings("tr").css("background-color", "");
		$(".panel").remove();
		$("#addtr").remove();
		
		var id = $(this).attr("id");
		//截取获取部门编号
		var gradeId = id.substring(1);
		//当前查看的和已经查看的是同一个，则关闭显示
		if (lastclick_class == gradeId) {
			$(this).parent().parent().parent().css("background-color", "");
			lastclick_class = -1;
			return;
		}
		lastclick_class = gradeId;
		
		$(this).parent().parent().parent().css("background-color", "#E6F1D8");
		$(this).parent().parent().parent().after("<tr id='addtr'><td colspan='3'></td></tr>");
		$("#addtr").children("td").append("<div class='panel panel-success'>" +
				"<div class='panel-heading'>部门信息如下</div>" +
				"<div class='panel-body myadd'></div>"+
				"</div>");
		//提交请求获取部门数据
		$.ajax({
		  url: "gradeclass/"+gradeId,
		  dataType: "json",
		  cache: true,
		  success: function(data){
	    	if($(data).length > 0) {
	    		$(data).each(function(i, item) {
	    			$(".myadd").append("<b>"+item.className+"&emsp;</b>");
		    	});
	    	} else {
	    		$(".panel-heading").remove();
	    		$(".myadd").append("<b>暂无部门&emsp;<a href='preAddClass'>添加</a></b>");	    		
	    	}
		  }
		});
	});
	/*--------------------------部门列表查看当前部门下的部门  END---------------------------*/
	
	
	/*--------------------------试卷列表查看当前试卷中的试题 BEGIN---------------------------*/
	var lastclick_subject = -1;
	$(".examPaper-subjects").click(function() {
		$("#afterTr").remove();
		//关闭试题 行
		if (lastclick_subject == $(this).attr("id")) {
			lastclick_subject = -1;
			$(".subject_info").not($(this).parent().parent().parent("tr")).show("slow");
			return;
		}
		lastclick_subject = $(this).attr("id");
		//如果需要展示试题信息，则隐藏其他试卷信息行
		$(".subject_info").not($(this).parent().parent().parent("tr")).hide("fast");
		
		$(this).parent().parent().parent().after("<tr id='afterTr'><td colspan='9'></td></tr>");
		$("#afterTr").children("td").append("<table class='table' style='width:100%;'>" +
				"<tr id='addtable-title-tr'><th>名称</th><th>选项A</th><th>选项B</th><th>选项C</th><th>选项D</th><th>分值</th><th>难易程度</th><th>操作</th>" +
				"</tr>" +
				"</table>");
		$.getJSON("getESM", "examPaperId="+$(this).attr("id"), function(data) {
			//试卷中没有试题
			if (data == null || data == "") {
				zeroModal.show({
					title : "试卷为空",
					content : "该试卷中还没有试题哦!",
					width : '200px',
					height : '130px',
					overlay : false,
					ok : true,
					onClosed : function() {
						//刷新当前页面
						location.reload();
					}
				});
				$(".subject_info").show("fast");
				$("#afterTr").remove();
				return false;
			}
			$.each(data, function(i, item) {
				//试题名称、选项长度控制
				var subjectId = item.subject.subjectId;
				var LENFTH_SUFFIX = "<a href='subjects?subjectId='+"+subjectId+">[...]</a>";
				var subjectName = item.subject.subjectName;
				if (subjectName.length > 8)
					subjectName = subjectName.substring(0, 8)+LENFTH_SUFFIX;
				var optionA = item.subject.optionA;
				if (optionA.length > 5)
					optionA = optionA.substring(0, 5)+LENFTH_SUFFIX;
				var optionB = item.subject.optionB;
				if (optionB.length > 5)
					optionB = optionB.substring(0, 5)+LENFTH_SUFFIX;
				var optionC = item.subject.optionC;
				if (optionC.length > 5)
					optionC = optionC.substring(0, 5)+LENFTH_SUFFIX;
				var optionD = item.subject.optionD;
				if (optionD.length > 5)
					optionD = optionD.substring(0, 5)+LENFTH_SUFFIX;
				var subjectScore = item.subject.subjectScore;
				var easy = item.subject.subjectEasy;
				var subjectEasy = "简单";
				if (easy == 0) {
					subjectEasy = "简单";
				} else if (easy == 1) {
					subjectEasy = "普通";
				} else if (easy == 2) {
					subjectEasy = "困难";
				}
				var sontr = "<tr id='viewSubject"+subjectId+"'>" +
						"<td>"+subjectName+"</td>" +
						"<td>"+optionA+"</td>" +
						"<td>"+optionB+"</td>" +
						"<td>"+optionC+"</td>" +
						"<td>"+optionD+"</td>" +
						"<td>"+subjectScore+"</td>" +
						"<td>"+subjectEasy+"</td>" +
						/*指定从试卷中移除试题需要的参数：试题编号，试卷编号，试题分数*/
						"<td><button class='btn btn-default btn-xs' onclick='removeSubjectWithExamPaper("+subjectId+", "+item.examPaper.examPaperId+", "+subjectScore+")'>移除</button></td>" +
						"</tr>";
				$("#addtable-title-tr").after(sontr);
			});
		});
		
		return false;
	});
	/*--------------------------试卷列表查看当前试卷中的试题 END---------------------------*/
	
	
});

/*--------------------------试卷列表查看试卷时移除指定试卷 BEGIN---------------------------*/
function removeSubjectWithExamPaper(subjectId, examPaperId, score) {
	//修改试卷题目数量-1, 修改试卷总分-score，移除当前试题
	$.ajax({
		type: "POST",
		data: "subjectId="+subjectId+"&examPaperId="+examPaperId+"&score="+score,
		url: "removeSubjectFromPaper",
		success: function() {
			//修改试卷行的试题数量和总分信息
			var num = parseInt($("#examPaper-sn"+examPaperId).text());
			var sc = parseInt($("#examPaper-score"+examPaperId).text());
			$("#examPaper-sn"+examPaperId).text(num-1);
			$("#examPaper-score"+examPaperId).text(sc-score);
			//移除成功就将前台对应 tr 移除
			$("#viewSubject"+subjectId).remove();
		},
		error: function() {
			alert("移除失败，请稍后再试！");
		}
	});
}
/*--------------------------试卷列表查看试卷时移除指定试卷 END---------------------------*/