package com.taohan.online.exam.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.taohan.online.exam.po.ClassInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.po.TeacherInfo;
import com.taohan.online.exam.service.TeacherInfoService;

/**
  *
  * <p>Title: TeacherInfoHandler</p>
  * <p>Description: HR</p>
  * @author: taohan
  * @date: 2018-8-14
  * @time: 上午9:16:53
  * @version: 1.0
  */

@Controller
@SuppressWarnings("all")
public class TeacherInfoHandler {
	
	@Autowired
	private TeacherInfoService teacherInfoService;
	
	private Logger logger = Logger.getLogger(TeacherInfoHandler.class);
	
	
	/**
	 * 获取  验证HR信息
	 * @param teacherAccount
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/validateTeacher", method=RequestMethod.POST)
	public void queryTeacherExists(@RequestParam(value="account") String teacherAccount,
			HttpServletResponse response) throws Exception {
		logger.info("获取HR "+teacherAccount+" 的信息");

		TeacherInfo teacherInfo = null;
		teacherInfo = teacherInfoService.getTeacherByAccount(teacherAccount);
		
		//HR账户不存在
		if (teacherInfo == null) {
			response.getWriter().print("1");
		} else {			
			response.getWriter().print(teacherInfo.getTeacherPwd());
		}
	}
	
	
	/**
	 * HR登录
	 * @param teacherAccount
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/teacherlogin", method=RequestMethod.POST)
	public String teacherLogin(@RequestParam("teacherAccount") String teacherAccount,
			HttpServletRequest request) {
		if (teacherAccount == null || "".equals(teacherAccount)) {
			logger.error("HR账号为空");
			request.setAttribute("error", "登录信息有误");
			return "/error";
		}
		logger.info("HR  "+teacherAccount+" 登录");
		
		//获取当前登录HR
		TeacherInfo teacherInfo = teacherInfoService.getTeacherByAccount(teacherAccount);
		
		if(teacherInfo == null){
			logger.error("HR账号为空");
			request.setAttribute("error", "账号不存在！");
			return "/error";
		}
		String teacherPwd = request.getParameter("teacherPwd");
		if(!teacherInfo.getTeacherPwd().equals(teacherPwd)){
			logger.error("密码错误");
			request.setAttribute("error", "密码错误！");
			return "/error";
		}
		//将当前登录HR 后台权限存入 Session
		request.getSession().setAttribute("adminPower", teacherInfo.getAdminPower());
		request.getSession().setAttribute("loginTeacher", teacherInfo);
		
		return "redirect:admin/index.jsp";
	}
	
	/**
	 * HR查看自己的信息
	 * @param teacherId
	 * @return
	 */
	@RequestMapping("/selfinfo/{teacherId}")
	public ModelAndView loginTeacherSelf(@PathVariable("teacherId") Integer teacherId) {
		ModelAndView model = new ModelAndView();
		logger.error("HR "+teacherId+" 查看自己的信息");
		if (teacherId == null) {
			model.setViewName("../error");
			return model;
		} else {
			List<TeacherInfo> teachers = new ArrayList<TeacherInfo>();
			TeacherInfo teacher = teacherInfoService.getTeacherById(teacherId);
			teachers.add(teacher);
			model.addObject("teachers", teachers);
			model.setViewName("/admin/teachers");
			
			return model;
		}
	}
	
	
	/**
	 * HR退出登录
	 * @throws IOException 
	 */
	@RequestMapping("/exitTeacher")
	public void exitTeacher(HttpSession session, HttpServletResponse response) throws IOException {
		session.removeAttribute("loginTeacher");
		session.removeAttribute("adminPower");
		
		response.sendRedirect("admin/login.jsp");
	}
	
	
	/**
	 * 查询HR集合
	 * @param startPage
	 * @param pageShow
	 * @return
	 */
	@RequestMapping(value="/teachers", method=RequestMethod.GET)
	public ModelAndView getTeachers(
			@RequestParam(value="startPage", required=false, defaultValue="1") Integer startPage,  //当前页码,默认第一页
			@RequestParam(value="pageShow", required=false, defaultValue="10") Integer pageShow /*每页显示数据量，默认10条*/) {
		logger.info("查询HR集合");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("admin/teachers");
		
		List<TeacherInfo> teachers;
		
		Map<String, Object> map = new HashMap<String, Object>();
		//计算当前查询起始数据索引
		int startIndex = (startPage-1) * pageShow;
		map.put("startIndex", startIndex);
		map.put("pageShow", pageShow);
		map.put("teacher", null);
		teachers = teacherInfoService.getTeachers(map);
		model.addObject("teachers", teachers);
		
		//获取HR总量
		int teacherTotal = teacherInfoService.getTeacherTotal();
		//计算总页数
		int pageTotal = 1;
		if (teacherTotal % pageShow == 0)
			pageTotal = teacherTotal / pageShow;
		else
			pageTotal = teacherTotal / pageShow + 1;			
		model.addObject("pageTotal", pageTotal);
		model.addObject("pageNow", startPage);
		
		return model;
	}
	
	/**
	 * 预修改HR
	 * @param teacherId
	 * @return
	 */
	@RequestMapping(value="/teacher/{teacherId}", method=RequestMethod.GET)
	public ModelAndView preUpdateTeacher(@PathVariable("teacherId") Integer teacherId) {
		logger.info("预修改HR处理");
		
		ModelAndView model = new ModelAndView();
		//获取要修改HR
		TeacherInfo teacher = teacherInfoService.getTeacherById(teacherId);
		model.setViewName("/admin/teacheredit");
		model.addObject("teacher", teacher);
		
		return model;
	}
	
	/**
	 * 修改/添加 HR
	 * @param teacherId
	 * @param isUpdate 操作标识
	 * @param teacherName
	 * @param teacherAccount
	 * @param teacherPwd
	 * @param adminPower
	 * @return
	 */
	@RequestMapping(value="/teacher/teacher", method=RequestMethod.POST)
	public String isUpdateOrAddTeacher(@RequestParam(value="teacherId", required=false) Integer teacherId,
			@RequestParam(value="isupdate", required=false) Integer isUpdate,
			@RequestParam("teacherName") String teacherName,
			@RequestParam("teacherAccount") String teacherAccount,
			@RequestParam("teacherPwd") String teacherPwd,
			@RequestParam("adminPower") Integer adminPower) {
		
		TeacherInfo teacher = new TeacherInfo();
			teacher.setTeacherId(teacherId);
			teacher.setTeacherName(teacherName);
			teacher.setTeacherAccount(teacherAccount);
			teacher.setTeacherPwd(teacherPwd);
			teacher.setAdminPower(adminPower);
		
		if (isUpdate != null) {  //修改
			logger.info("修改HR "+teacher+" 的信息");
			int row = teacherInfoService.isUpdateTeacherInfo(teacher);			
		} else {  //添加
			logger.info("添加HR "+teacher+" 的信息");
			int row = teacherInfoService.isAddTeacherInfo(teacher);
		}
		
		return "redirect:/teachers";
	}
	
	
	/**
	 * 删除HR
	 * @param teacherId
	 * @return
	 */
	@RequestMapping(value="/teacher/{teacherId}", method=RequestMethod.DELETE)
	public String isDelTeacher(@PathVariable("teacherId") Integer teacherId) {
		logger.info("删除HR "+teacherId);
		
		int row = teacherInfoService.isDelTeacherInfo(teacherId);
		
		return "redirect:/teachers";
	}
}
