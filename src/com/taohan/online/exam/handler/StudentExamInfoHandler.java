package com.taohan.online.exam.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.taohan.online.exam.charts.StudentExamInfoCharts;
import com.taohan.online.exam.po.ClassInfo;
import com.taohan.online.exam.po.StudentExamInfo;
import com.taohan.online.exam.po.StudentInfo;
import com.taohan.online.exam.service.ClassInfoService;
import com.taohan.online.exam.service.StudentExamInfoService;
import com.taohan.online.exam.service.StudentInfoService;

/**
  *
  * <p>Title: StudentExamInfoHandler</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-9-19
  * @time: 上午10:10:33
  * @version: 1.0
  */

@Controller
public class StudentExamInfoHandler {

	@Autowired
	private StudentExamInfoService studentExamInfoService;
	@Autowired
	private ClassInfoService classInfoService;
	@Autowired
	private StudentInfoService studentInfoService;
	@Autowired
	private Gson gson;
	
	private Logger logger = Logger.getLogger(StudentExamInfoHandler.class);
	
	/**
	 * 所有员工测评信息 图表 Json 字符串生成
	 * @param teacherId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/examCount")
	public void getStudentExamCount(@RequestParam("tid") Integer teacherId, HttpServletResponse response) throws IOException {
		if (teacherId == null) {
			response.getWriter().print("TID-NULL");			
		} else {
			//获取当前班主任对应的班级
			ClassInfo classInfo = classInfoService.getClassByTeacherId(teacherId);
			//获取员工测评信息
			List<StudentExamInfo> stuExamInfos = studentExamInfoService.getStudentExamCountByClassId(classInfo.getClassId());
			
			response.getWriter().print(StudentExamInfoCharts.createExamCountBarJson(stuExamInfos));
		}
	}
	
	
	/**
	 * 获取班级中的所有员工
	 * @param teacherId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/stus")
	public void getStudentsByClassId(@RequestParam("tid") Integer teacherId, HttpServletResponse response) throws IOException {
		if (teacherId == null) {
			response.getWriter().print("TID-NULL");			
		} else {
			//获取当前班主任对应的班级
			ClassInfo classInfo = classInfoService.getClassByTeacherId(teacherId);
			//获取所有员工信息
			List<StudentInfo> stus = studentInfoService.getStudentsByClassId(classInfo.getClassId());
			
			response.getWriter().print(gson.toJson(stus));
		}
	}
	
	
	/**
	 * 班级下所有员工测评平均分等信息 图表 Json 生成
	 * @param teacherId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/avgcounts")
	public void getAllStudentAvgScoreCount(@RequestParam("tid") Integer teacherId, HttpServletResponse response) throws IOException {
		if (teacherId == null) {
			response.getWriter().print("TID-NULL");			
		} else {
			//获取当前班主任对应的班级
			ClassInfo classInfo = classInfoService.getClassByTeacherId(teacherId);
			//获取所有员工信息 平局分等信息
			List<StudentExamInfo> stuExamInfos = studentExamInfoService.getAllStudentAvgScoreCount(classInfo.getClassId());
			
			response.getWriter().print(StudentExamInfoCharts.createAvgCountLineJson(stuExamInfos));
		}
	}
	
	
	@RequestMapping("/stuexam")
	public void getStudentExamInfoById(@RequestParam("stuId") Integer studentId, HttpServletResponse response) throws IOException {
		//获取员工测评信息
		List<StudentExamInfo> stuExamInfos = studentExamInfoService.getStudentExamInfo(studentId);
		
		response.getWriter().print(StudentExamInfoCharts.createStudentExamLineJson(stuExamInfos));
	}
}
