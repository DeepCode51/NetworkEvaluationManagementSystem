package com.taohan.online.exam.handler;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.taohan.online.exam.po.CourseInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.service.CourseInfoService;
import com.taohan.online.exam.service.GradeInfoService;

/**
  *
  * <p>Title: CourseInfoHandler</p>
  * <p>Description: 科目</p>
  * @author: taohan
  * @date: 2018-8-15
  * @time: 下午5:32:03
  * @version: 1.0
  */

@Controller
@SuppressWarnings("all")
public class CourseInfoHandler {
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private GradeInfoService gradeInfoService;
	
	private Logger logger = Logger.getLogger(CourseInfoHandler.class);
	
	/**
	 * 获取科目信息
	 * @param gradeId 班级编号
	 * @param division 分类情况
	 * @return
	 */
	@RequestMapping("/courses")
	public ModelAndView getCourses(@RequestParam(value="gradeId", required=false) Integer gradeId,
			@RequestParam(value="division", required=false) Integer division) {
		logger.info("获取科目集合 班级条件 "+gradeId+" 分科条件 "+division);
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/courses");
		
		CourseInfo course = new CourseInfo();
		if (gradeId != null)
			course.getGrade().setGradeId(gradeId);
		if (division != null)
			course.setDivision(division);
		List<CourseInfo> courses = courseInfoService.getCourses(course);
		model.addObject("courses", courses);
		
		return model;
	}
	
	/**
	 * 根据科目编号获取学科信息
	 * @param courseId 科目编号
	 * @return
	 */
	@RequestMapping("/course/{courseId}")
	public ModelAndView getCourseById(@PathVariable("courseId") Integer courseId) {
		logger.info("获取科目信息 科目编号 "+courseId);
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/courseedit");
		
		CourseInfo course = courseInfoService.getCourseById(courseId);
		model.addObject("course", course);
		/** 获取所有班级列表 */
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);
		
		return model;
	}
	
	/**
	 * 添加/修改科目信息
	 * @param courseId 科目编号
	 * @param isUpdate 标识是否为修改操作
	 * @param courseName 科目名称
	 * @param division 分类情况
	 * @param gradeId 班级编号
	 * @return
	 */
	@RequestMapping(value="/course/course", method=RequestMethod.POST)
	public String isUpdateOrAddCourse(@RequestParam(value="courseId", required=false) Integer courseId,
			@RequestParam(value="isupdate", required=false) Integer isUpdate,
			@RequestParam("courseName") String courseName,
			@RequestParam("division") Integer division,
			@RequestParam("gradeId") Integer gradeId) {
		
		CourseInfo course = new CourseInfo();
			course.setCourseId(courseId);
			course.setCourseName(courseName);
			course.setDivision(division);
			GradeInfo grade = new GradeInfo();
			grade.setGradeId(gradeId);
			course.setGrade(grade);
		
		//修改
		if (isUpdate != null) {
			logger.info("修改科目 "+course+" 的信息");
			int row = courseInfoService.isUpdateCourse(course);			
		}
		//添加
		else {
			logger.info("添加科目 "+course+" 的信息");
			int row = courseInfoService.isAddCourse(course);
		}
		
		return "redirect:/courses";
	}
	
	/**
	 * 删除科目
	 * @param courseId 待删除科目编号
	 * @return
	 */
	@RequestMapping(value="/course/{courseId}", method=RequestMethod.DELETE)
	public String isDelTeacher(@PathVariable("courseId") Integer courseId) {
		logger.info("删除科目 "+courseId);
		
		int row = courseInfoService.isDelCourse(courseId);
		
		return "redirect:/courses";
	}
	
	/**
	 * 预添加科目信息
	 * @return
	 */
	@RequestMapping("/preAddCourse")
	public ModelAndView preAddCourse() {
		logger.info("预添加科目信息");
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/courseedit");
		/** 获取班级集合 */
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);
		
		return model;
	}
}
