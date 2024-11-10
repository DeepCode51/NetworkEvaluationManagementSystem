package com.taohan.online.exam.handler;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.taohan.online.exam.service.ExamPaperInfoService;
import com.taohan.online.exam.service.StudentInfoService;
import com.taohan.online.exam.service.SubjectInfoService;
import com.taohan.online.exam.service.TeacherInfoService;

/**
  *
  * <p>Title: AdminHomeHandler</p>
  * <p>Description: 后台首页相关</p>
  * @author: taohan
  * @date: 2018-9-18
  * @time: 下午1:59:22
  * @version: 1.0
  */

@Controller
public class AdminHomeHandler {

	@Autowired
	ExamPaperInfoService examPaperInfoService;
	@Autowired
	SubjectInfoService subjectInfoService;
	@Autowired
	TeacherInfoService teacherInfoService;
	@Autowired
	StudentInfoService studentInfoService;
	@Autowired
	Gson gson;
	
	private Logger logger = Logger.getLogger(AdminHomeHandler.class);
	
	
	@RequestMapping("/homeInfo")
	public void homeInfo(HttpServletResponse response) throws IOException {
		logger.info("加载后台首页相关数据");
		
		int examPaperTotal = examPaperInfoService.getExamPpaerTotal();
		int subjectTotal = subjectInfoService.getSubjectTotal();
		int teacherTotal = teacherInfoService.getTeacherTotal();
		int studentTotal = studentInfoService.getStudentTotal();
		
		String json = "{\"examPaperTotal\":"+examPaperTotal+", " +
				"\"subjectTotal\":"+subjectTotal+", " +
				"\"teacherTotal\":"+teacherTotal+", " +
				"\"studentTotal\":"+studentTotal+"}";
		
		response.getWriter().print(json);
	}
}
