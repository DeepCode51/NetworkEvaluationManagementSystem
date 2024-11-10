package com.taohan.online.exam.handler;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.service.GradeInfoService;

/**
  *
  * <p>Title: GradeInfoHandler</p>
  * <p>Description: 班级</p>
  * @author: taohan
  * @date: 2018-8-14
  * @time: 上午10:03:33
  * @version: 1.0
  */

@Controller
public class GradeInfoHandler {

	@Autowired
	@Qualifier("gson")
	private Gson gson;
	@Autowired
	private GradeInfoService gradeInfoService;
	
	private Logger logger = Logger.getLogger(GradeInfoHandler.class);
	
	/**
	 * 获取所有班级集合
	 * @return
	 */
	@RequestMapping(value="/grades")
	public ModelAndView getGrades() {
		logger.info("获取所有班级");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("admin/grades");
		//获取所有班级
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);
		
		return model;
	}
	
	
	/**
	 * 预添加班级处理
	 * @param map
	 * @return
	 */
	@RequestMapping("/preAddGrade")
	public String preAddGrade(Map<String, Object> map) {
		logger.info("班级添加预处理");
		
		map.put("grade", new GradeInfo());
		
		return "admin/gradeedit";
	}
	
	/**
	 * 添加班级
	 * @param grade
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/grade", method=RequestMethod.POST)
	public String isAddGrade(GradeInfo grade, HttpServletRequest request) {
		logger.info("添加班级 "+grade);

		if (grade == null) {
			logger.error("班级 "+grade+" 为空");
			
			request.setAttribute("error", "班级添加失败，请稍后再试！");
			return "error";
		}
		int row = gradeInfoService.isAddGrade(grade);
		if (row < 1) {
			logger.error("班级添加失败");
			
			request.setAttribute("error", "班级添加失败，请稍后再试！");
			return "error";
		}
		
		return "redirect:grades";
	}
	
	/**
	 * 预修改班级处理
	 * @param gradeId 待修改班级编号
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/grade/update/{gradeId}", method=RequestMethod.GET)
	public String preUpdateGrade(@PathVariable("gradeId") Integer gradeId,
			Map<String, Object> map) {
		logger.info("班级修改预处理");
		
		map.put("grade", gradeInfoService.getGradeById(gradeId));
		
		return "/admin/gradeedit";
	}
	
	/**
	 * 修改班级信息
	 * @param grade
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/grade/update/grade", method=RequestMethod.PUT)
	public String isUpdateGrade(GradeInfo grade, HttpServletRequest request) {
		logger.info("修改班级 "+grade+" 的信息");
		
		int row = gradeInfoService.isUpdateGrade(grade);
		if (row < 1) {
			logger.error("班级修改失败");
			
			request.setAttribute("error", "班级修改失败，请稍后再试！");
			return "/error";
		}
		
		return "redirect:/grades";
	}
	
	/**
	 * 删除班级
	 * @param gradeId
	 * @param request
	 * @return
	 */
	@RequestMapping(value="grade/del/{gradeId}", method=RequestMethod.DELETE)
	public String isDelGrade(@PathVariable("gradeId") Integer gradeId, HttpServletRequest request) {
		logger.info("删除班级 "+gradeId);
		
		int row = gradeInfoService.isDelGrade(gradeId);
		if (row < 1) {
			logger.error("班级删除失败");
			
			request.setAttribute("error", "班级删除失败，请稍后再试！");
			return "/error";
		}
		
		return "redirect:/grades";
	}
}
