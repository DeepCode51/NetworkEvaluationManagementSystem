package com.taohan.online.exam.charts;

import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Magic;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.code.X;
import com.github.abel533.echarts.code.Y;
import com.github.abel533.echarts.feature.MagicType;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Line;
import com.taohan.online.exam.po.ClassInfo;

/**
  *
  * <p>Title: StudentCount</p>
  * <p>Description: (班级下/所有)班级的员工总量 相关图表Json数据生成</p>
  * @author: taohan
  * @date: 2018-9-17
  * @time: 下午7:03:13
  * @version: 1.0
  */

@Repository
public class StudentCount {

	/**
	 * 班级对应员工人数折线图
	 * @param data
	 * @return
	 */
	public static String createBarJson(Map<String, Object> data) {
		Set<String> set = data.keySet();
		
		GsonOption option = new GsonOption();
		option.title().text("班级员工数量统计").x(X.center).y(Y.top).borderWidth(1).textStyle().color("#000000");
		option.toolbox().show(true).feature(Tool.mark, Tool.restore, new MagicType(Magic.bar, Magic.line), Tool.saveAsImage).x(X.right).y(Y.top);
		//数据默认触发， 鼠标移入显示竖线  trigger(Trigger.axis)
		option.tooltip().formatter("{b} {c}人").trigger(Trigger.axis);

		option.legend().data("班级总人数").x(X.center).y(Y.bottom).borderWidth(1);
		
		Line line = new Line("班级总人数");
		
		//值轴
		ValueAxis valueAxis = new ValueAxis();
		valueAxis.axisLabel().formatter("{value}人").textStyle().color("#000000");
		//valueAxis.min(0);
		option.yAxis(valueAxis);
		
		//类目轴
		CategoryAxis categoryAxis = new CategoryAxis();
		//interval(0)：设置横轴信息全部显示
		//rotate(-30)：设置 -30 度角倾斜显示
		categoryAxis.axisLabel().interval(0).rotate(-30).textStyle().color("#000000");
		
		for (String className : set) {
			categoryAxis.data(className);
			ClassInfo classInfo = (ClassInfo)data.get(className);
			line.data(classInfo.getClassId());
		}
		
		option.xAxis(categoryAxis);
		line.smooth(true);
		option.series(line);
		option.grid().x(100);
		System.out.println(option.toString());
		return option.toString();
	}
}
