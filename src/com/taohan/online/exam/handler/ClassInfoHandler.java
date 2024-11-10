package com.taohan.online.exam.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.taohan.online.exam.charts.StudentCount;
import com.taohan.online.exam.po.ClassInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.po.TeacherInfo;
import com.taohan.online.exam.service.ClassInfoService;
import com.taohan.online.exam.service.GradeInfoService;
import com.taohan.online.exam.service.TeacherInfoService;

/**
  *
  * <p>Title: ClassInfoHandler</p>
  * <p>Description: 班级</p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午2:18:14
  * @version: 1.0
  */

@Controller
@SuppressWarnings("all")
public class ClassInfoHandler {

	@Autowired
	private ClassInfoService classInfoService;
	@Autowired
	private GradeInfoService gradeInfoService;
	@Autowired
	private TeacherInfoService teacherInfoService;
	@Autowired
	private TeacherInfo teacher;
	@Autowired
	private ClassInfo classInfo;
	@Autowired
	private Gson gson;
	
	private Logger logger = Logger.getLogger(ClassInfoHandler.class);
	
	/**
	 * 获取所有班级
	 * @param gradeId 班级编号
	 * @param className 班级名称  可用于模糊查询
	 * @param classId  班级编号
	 * @return
	 */
	@RequestMapping(value="/classes", method=RequestMethod.GET)
	public ModelAndView getClasses(@RequestParam(value="gradeId", required=false) Integer gradeId,
			@RequestParam(value="className", required=false) String className,
			@RequestParam(value="classId", required=false) Integer classId) {
		logger.info("获取班级集合 条件：gradeId： "+gradeId+", 班级编号："+classId+", 班级："+className);
		ModelAndView model = new ModelAndView();
		ClassInfo classInfo = new ClassInfo();
		
		/*处理查询条件*/
		if (gradeId != null) {
			GradeInfo gradeInfo = new GradeInfo();
			gradeInfo.setGradeId(gradeId);
			classInfo.setGrade(gradeInfo);
		}
		if (classId != null)
			classInfo.setClassId(classId);
		if (className != null) {
			if (className.trim() != "")
				classInfo.setClassName(className);
		}
		
		List<ClassInfo> classes = classInfoService.getClasses(classInfo);
		model.setViewName("admin/classes");
		model.addObject("classes", classes);
		
		return model;
	}
	
	
	/**
	 * 预添加班级处理
	 * @return
	 */
	@RequestMapping("/preAddClass")
	public ModelAndView preAddClass() {
		logger.info("预添加班级信息");
		
		ModelAndView model = new ModelAndView();
		//获取班级信息
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.setViewName("admin/classedit");
		model.addObject("grades", grades);
		//获取不是班主任的HR
		teacher.setIsWork(0);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", null);
		map.put("pageShow", null);
		map.put("teacher", teacher);
		List<TeacherInfo> teachers = teacherInfoService.getTeachers(map);
		model.addObject("teachers", teachers);
		model.addObject("editClass", new ClassInfo());
		
		return model;
	}
	
	/**
	 * 添加班级
	 * @param classInfo 班级信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/class", method=RequestMethod.POST)
	public String isAddClass(ClassInfo classInfo, HttpServletRequest request) {
		logger.info("添加班级信息 "+classInfo);
		
		//修改HR班主任状态
		String returnMsg = isChangeTeacherWork(1, classInfo.getTeacher().getTeacherId());
		if (returnMsg != null) {
			request.setAttribute("error", "修改HR班主任状态 对应HR编号有误");
			return "error";
		}

		//添加
		int row = classInfoService.isAddClass(classInfo);
		if (row < 1) {
			logger.error("班级 "+classInfo+" 删除失败");
			
			request.setAttribute("error", "班级 "+classInfo.getClassName()+" 添加失败，请稍后再试！");
			return "../error";
		}
		
		return "redirect:/classes";
	}
	
	
	/**
	 * 删除班级
	 * @param classId 班级编号
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/del/class/{classId}", method=RequestMethod.DELETE)
	public String isDelClass(@PathVariable("classId") Integer classId, HttpServletRequest request) {
		logger.info("删除班级 "+classId);
		
		//将删除班级对于之前班主任改为 非班主任状态
		//需要在删除班级之前修改，如果先删除了班级，再根据班级获取HR编号，就不能获取
		ClassInfo delClass = classInfoService.getClassById(classId);
		String returnMsg = isChangeTeacherWork(0, delClass.getTeacher().getTeacherId());
		if (returnMsg != null) {
			request.setAttribute("error", "修改HR班主任状态 对应HR编号有误");
			return "error";
		}

		//删除
		int row = classInfoService.isDelClass(classId);
		if (row < 1) {
			logger.error("班级 "+classId+" 删除失败");
			
			request.setAttribute("error", "班级删除失败，请稍后再试！");
			return "../error";
		}
		
		return "redirect:/classes";
	}
	
	
	/**
	 * 预修改班级处理
	 * @param classId 班级编号
	 * @return
	 */
	@RequestMapping(value="edit/class/{classId}", method=RequestMethod.GET)
	public ModelAndView preUpdateClass(@PathVariable("classId") Integer classId) {
		logger.info("预修改班级处理");
		
		ModelAndView model = new ModelAndView();
		//获取要修改班级
		ClassInfo classInfo = classInfoService.getClassById(classId);
		model.setViewName("/admin/classedit");
		model.addObject("editClass", classInfo);
		List<GradeInfo> grades = gradeInfoService.getGrades();
		//获取不是班主任的HR
		teacher.setIsWork(0);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", null);
		map.put("pageShow", null);
		map.put("teacher", teacher);
		List<TeacherInfo> teachers = teacherInfoService.getTeachers(map);
		//如果没有可用班主任
		if (teachers.size() == 0 || teachers == null) {
			teacher.setTeacherId(classInfo.getTeacher().getTeacherId());
			teacher.setTeacherName("暂无剩余HR");
			teachers.add(teacher);
		}
		model.addObject("teachers", teachers);
		model.addObject("grades", grades);
		
		return model;
	}
	
	
	/**
	 * 修改班级信息
	 * @param classInfo 班级信息
	 * @param request
	 * @param lastTeacherId  上一个班主任编号，修改其 班主任状态
	 * @return
	 */
	@RequestMapping(value="edit/class/class", method=RequestMethod.PUT)
	public String isUpdateClass(ClassInfo classInfo, HttpServletRequest request, 
			@RequestParam(value="lastTeacher", required=false) Integer lastTeacherId) {
		//修改上一HR不为班主任状态
		if (lastTeacherId != null) {
			String returnMsg = isChangeTeacherWork(0, lastTeacherId);
			if (returnMsg != null) {
				request.setAttribute("error", "修改HR班主任状态 对应HR编号有误");
				return "/error";
			}
		}
		//修改当前HR为班主任状态
		String returnMsg = isChangeTeacherWork(1, classInfo.getTeacher().getTeacherId());
		if (returnMsg != null) {
			request.setAttribute("error", "修改HR班主任状态 对应HR编号有误");
			return "/error";
		}
		
		logger.info("修改班级 "+classInfo);
		
		int row = classInfoService.isUpdateClass(classInfo);
		if (row < 1) {
			logger.error("班级 "+classInfo+" 修改失败");
			
			request.setAttribute("error", "班级修改失败，请稍后再试！");
			return "../error";
		}
		
		return "redirect:/classes";
	}
	
	
	/**
	 * 获取指定班级下的班级
	 * @param gradeId 班级编号
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/gradeclass/{gradeId}", method=RequestMethod.GET)
	public void getClassesByGradeId(@PathVariable("gradeId") Integer gradeId,
			HttpServletResponse response) throws IOException {
		logger.info("获取班级 "+gradeId+" 下的班级集合");
		
		List<ClassInfo> classes = classInfoService.getClassByGradeId(gradeId);
		
		String json = gson.toJson(classes);
		response.getWriter().print(json);
	}
	
	
	/**
	 * 修改HR(班主任)工作状态
	 * @param status 是否为班主任标识
	 * @param teacherId HR编号
	 */
	private String isChangeTeacherWork(int status, Integer teacherId) {
		logger.info("修改HR "+teacherId+" 的状态为 "+status);
		teacher.setIsWork(status);
		if (teacherId == null) {
			logger.error("修改HR班主任状态 对应HR编号有误");
			return "修改HR班主任状态 对应HR编号有误";
		}
		teacher.setTeacherId(teacherId);
		int row = teacherInfoService.updateTeacherIsWork(teacher);
		return null;
	}
	
	@RequestMapping("/stuCount")
	public void getStudentCountForClass(
			@RequestParam(value="gradeId", required=false) Integer gradeId,
			HttpServletResponse response) throws IOException {
		Map<String, Object> map = classInfoService.getStudentCountForClass(gradeId);
		String json = StudentCount.createBarJson(map);
		
		response.getWriter().print(json);
	}
	
	/**
	 * 预添加班级处理
	 * @return
	 */
	@RequestMapping("/preStudentCount")
	public ModelAndView preStudentCount() {
		
		ModelAndView model = new ModelAndView();
		//获取班级信息
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.setViewName("admin/charts/studentCount");
		model.addObject("grades", grades);
		
		return model;
	}
	
}
