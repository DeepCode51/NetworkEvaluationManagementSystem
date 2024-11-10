package com.taohan.online.exam.charts;

import java.util.List;

import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Magic;
import com.github.abel533.echarts.code.PointerType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.code.X;
import com.github.abel533.echarts.code.Y;
import com.github.abel533.echarts.feature.MagicType;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Bar;
import com.github.abel533.echarts.series.Line;
import com.taohan.online.exam.po.StudentExamInfo;

/**
  *
  * <p>Title: StudentExamInfoCharts</p>
  * <p>Description: 员工测评信息 图表 Json 数据 生成</p>
  * @author: taohan
  * @date: 2018-9-19
  * @time: 上午10:26:55
  * @version: 1.0
  */

public class StudentExamInfoCharts {

	
	public static String createExamCountBarJson(List<StudentExamInfo> examInfos) {
		GsonOption option = new GsonOption();
		option.title().text("员工测评次数统计").x(X.center).y(Y.top).borderWidth(1).textStyle().color("#000000");
		option.toolbox().show(true).feature(Tool.mark, Tool.restore, new MagicType(Magic.bar, Magic.line), Tool.saveAsImage).x(X.right).y(Y.top);
		option.tooltip().show(true).formatter("{b} {c}次");
		
		option.legend().data("员工测评次数统计").x(X.center).y(Y.bottom);
		
		Bar bar = new Bar();
		
		//值轴
		ValueAxis valueAxis = new ValueAxis();
		//设置y轴不出现小数值
		valueAxis.interval(1);
		valueAxis.axisLabel().formatter("{value} 次");
		option.yAxis(valueAxis);
		
		//类目轴
		CategoryAxis categoryAxis = new CategoryAxis();
		categoryAxis.axisLabel().interval(0);
		
		for (StudentExamInfo studentExamInfo : examInfos) {
			bar.data(studentExamInfo.getExamSum());
			categoryAxis.data(studentExamInfo.getStudentName());
		}
		
		bar.barCategoryGap("20");
		option.xAxis(categoryAxis);
		option.series(bar);
		
		return option.toString();
	}
	
	
	public static String createAvgCountLineJson(List<StudentExamInfo> examInfos) {
		GsonOption option = new GsonOption();
		option.title().text("员工测评平均成绩统计").x(X.center).y(Y.top).borderWidth(1).textStyle().color("#000000");
		option.toolbox().show(true).feature(Tool.mark, Tool.restore, new MagicType(Magic.bar, Magic.line), Tool.saveAsImage).x(X.right).y(Y.top);
		option.tooltip().show(true).trigger(Trigger.axis).axisPointer().type(PointerType.cross).crossStyle().color("#999");
		
		option.legend().data("测评次数", "平均分").x(X.center).y(Y.bottom);
		
		Line line = new Line("测评次数").smooth(true);
		Bar bar = new Bar("平均分");
		
		//值轴
		ValueAxis valueAxis = new ValueAxis();
		//设置y轴不出现小数值
		valueAxis.interval(1);
		valueAxis.axisLabel().formatter("{value} 次");
		//option.yAxis(valueAxis);
		
		ValueAxis valueAxis1 = new ValueAxis();
		valueAxis1.interval(1);
		valueAxis1.axisLabel().formatter("{value} 分");
		option.yAxis(valueAxis, valueAxis1);
		
		//类目轴
		CategoryAxis categoryAxis = new CategoryAxis();
		categoryAxis.axisLabel().interval(0);
		
		for (StudentExamInfo studentExamInfo : examInfos) {
			if (studentExamInfo.getAvgScore() != null || studentExamInfo.getExamSum() != 0) {
				bar.data(studentExamInfo.getAvgScore()/studentExamInfo.getExamSum());
			} else {
				bar.data("暂无记录");				
			}
			line.data(studentExamInfo.getExamSum());
			categoryAxis.data(studentExamInfo.getStudentName());
		}
		
		//实现双 y 轴，使用 yAxisIndex() 指定应用到哪个 y 轴
		bar.barCategoryGap("20").yAxisIndex(1);
		option.xAxis(categoryAxis);
		option.series(bar, line);
		
		return option.toString();
	}
	
	
	public static String createStudentExamLineJson(List<StudentExamInfo> examInfos) {
		GsonOption option = new GsonOption();
		option.title().text("员工测评试卷得分统计").x(X.center).y(Y.top).borderWidth(1).textStyle().color("#000000");
		option.toolbox().show(true).feature(Tool.mark, Tool.restore, new MagicType(Magic.bar, Magic.line), Tool.saveAsImage).x(X.right).y(Y.top);
		option.tooltip().show(true).formatter("{b} {c}分").trigger(Trigger.axis);
		option.legend().data("得分").x(X.center).y(Y.bottom);
		
		Line line = new Line("试卷得分");
		
		//值轴
		ValueAxis valueAxis = new ValueAxis();
		//设置y轴不出现小数值
		valueAxis.interval(1);
		valueAxis.axisLabel().formatter("{value} 分");
		option.yAxis(valueAxis);
		
		
		//类目轴
		CategoryAxis categoryAxis = new CategoryAxis();
		categoryAxis.axisLabel().interval(0).rotate(-30);
		
		for (StudentExamInfo studentExamInfo : examInfos) {
			line.data(studentExamInfo.getExamScore());
			categoryAxis.data(studentExamInfo.getExamPaperName());
		}
		
		option.xAxis(categoryAxis);
		option.series(line);
		
		System.out.println(option.toString());
		return option.toString();
	}
}
