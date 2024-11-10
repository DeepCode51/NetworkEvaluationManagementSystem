package com.taohan.online.exam.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.security.auth.Subject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.taohan.online.exam.po.CourseInfo;
import com.taohan.online.exam.po.ExamPaperInfo;
import com.taohan.online.exam.po.ExamSubjectMiddleInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.po.SubjectInfo;
import com.taohan.online.exam.service.ExamPaperInfoService;
import com.taohan.online.exam.service.ExamSubjectMiddleInfoService;
import com.taohan.online.exam.service.SubjectInfoService;

/**
  *
  * <p>Title: ExamSubjectMiddleInfoHandler</p>
  * <p>Description: 试卷试题--关联</p>
  * @author: taohan
  * @date: 2018-8-20
  * @time: 下午4:21:05
  * @version: 1.0
  */

@Controller
@Scope("prototype")
@SuppressWarnings("all")
public class ExamSubjectMiddleInfoHandler {

	@Autowired
	private ExamSubjectMiddleInfoService esmService;
	@Autowired
	private ExamPaperInfoService examPaperInfoService;
	@Autowired
	private SubjectInfoService subjectInfoService;
	@Autowired
	private ExamSubjectMiddleInfo esm;
	@Autowired
	private ExamPaperInfo examPaper;
	@Autowired
	private SubjectInfo subject;
	@Autowired
	private CourseInfo course;
	@Autowired
	private GradeInfo grade;
	@Autowired
	private Gson gson;
	
	private Logger logger = Logger.getLogger(ExamSubjectMiddleInfoHandler.class);
	
	
	/**
	 * 查询试卷-试题信息
	 * 根据多条件查询
	 * @param examPaperId 试卷编号
	 * @param courseName 科目名称
	 * @param courseId 科目百年好
	 * @param gradeId 班级编号
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getESM", method={RequestMethod.GET, RequestMethod.POST})
	public void getExamPaperWithSubject(
			@RequestParam(value="examPaperId", required=false) Integer examPaperId,
			@RequestParam(value="courseName", required=false) String courseName,
			@RequestParam(value="courseId", required=false) Integer courseId,
			@RequestParam(value="gradeId", required=false) Integer gradeId,
			HttpServletResponse response) throws IOException {
		ModelAndView model = new ModelAndView();
		
		/*条件处理*/
		if (examPaperId != null) examPaper.setExamPaperId(examPaperId);
		if (courseName != null) course.setCourseName(courseName);
		if (courseId != null) course.setCourseId(courseId);
		if (gradeId != null) grade.setGradeId(gradeId);
		subject.setCourse(course);
		subject.setGrade(grade);
		
		esm.setExamPaper(examPaper);
		esm.setSubject(subject);
		
		logger.info("查询试卷试题信息 With "+esm);
		List<ExamSubjectMiddleInfo> esms = esmService.getExamPaperWithSubject(esm);
		
		response.getWriter().print(gson.toJson(esms));
	}
	
	/**
	 * 手动添加试题
	 * 手动将选择的试题添加到指定试卷中  -- 正式添加处理
	 * @param examPaperId 试卷编号
	 * @param session
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/handAdd", method={RequestMethod.GET, RequestMethod.POST})
	public void isHandAddSubjectToExamPaper(
			@RequestParam(value="examPaperId") Integer examPaperId,
			HttpSession session,
			HttpServletResponse response) throws Exception {
		//添加试题总分统计
		int scoreSum = 0;
		//添加试题总量统计
		int subjectSum = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("examPaperId", examPaperId);
		ArrayList<Integer> subjectIds = new ArrayList<Integer>();
		
		//试题信息
		List<String> ids = (List<String>) session.getAttribute("ids");
		if (ids != null) {
			for (String is : ids) {
				//分割试题编号和分数
				String[] idAndScore = is.split(",");
				subjectIds.add(Integer.parseInt(idAndScore[0]));
				//累加试题分数
				scoreSum += Integer.parseInt(idAndScore[1]);
				//累加试题数量
				subjectSum += 1;
			}
			/** 需要添加试题集合 */
			map.put("subjectIds", subjectIds);
		} else {
			logger.error("试题集合为空，不能进行添加试题操作！");
			response.getWriter().print("需要添加的试题为空，操作失败！");
			return;
		}
		logger.info("添加试题集合到试卷 "+examPaperId);
		//总分和题目数量信息
		Map<String, Object> scoreWithNum = new HashMap<String, Object>();
		scoreWithNum.put("subjectNum", subjectSum);
		scoreWithNum.put("score", scoreSum);
		scoreWithNum.put("examPaperId", examPaperId);
		/** 修改试卷总分 */
		examPaperInfoService.isUpdateExamPaperScore(scoreWithNum);
		/** 修改试卷试题总量 */
		examPaperInfoService.isUpdateExamPaperSubjects(scoreWithNum);
		
		/** 添加试题到试卷中 */
		esmService.isAddESM(map);
		
		response.getWriter().print("试题已成功添加到试卷中！");
	}
	
	
	/**
	 * 手动添加试题到试卷时 向 Session中存入试题信息
	 * @param subjectId 试题编号
	 * @param examPaperId 试卷编号
	 * @param score 试题分数
	 * @param handle 操作标识, 自动 OR 手动
	 * @param session
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/getChooseSubId")
	public void getChooseSubjectId(
			@RequestParam("subjectId") Integer subjectId,
			@RequestParam("examPaperId") Integer examPaperId,
			@RequestParam("score") Integer score,
			@RequestParam(value="handle", required=false) Integer handle,
			HttpSession session, HttpServletResponse response) throws IOException {
		List<String> ids = null;
		/*
		 * 添加到 Session 中需先判断该试题是否已经存在该试卷中
		 * 如果存在，则不进行添加；反之添加
		 */
		examPaper.setExamPaperId(examPaperId);
		subject.setSubjectId(subjectId);
		esm.setExamPaper(examPaper);
		esm.setSubject(subject);
		/** 验证添加记录 是否已经存在 */
		Integer esmId = esmService.getEsmByExamIdWithSubjectId(esm);
		if (esmId == null) {
			logger.error("需要添加的试题 "+subjectId+" 暂不存在试卷 "+examPaperId+" 中，可进行添加");
			ids = (List<String>) session.getAttribute("ids");
			
			/** Session 记录非空验证 */
			if (subjectId != null && score != null) {
				//第一次添加
				if (ids == null) {
					ids = new ArrayList<String>();
					ids.add((subjectId+","+score));
					logger.info("Session 添加试题：是否手动"+handle+", 试题编号："+subjectId+", 试题分数"+score);
				} else {
					//存在就移除,反之添加
					if (ids.contains((subjectId+","+score))) {
						ids.remove((subjectId+","+score));
						logger.info("Session 移除试题：是否手动"+handle+", 试题编号："+subjectId+", 试题分数"+score);
					} else {
						ids.add((subjectId+","+score));
						logger.info("Session 添加试题：是否手动"+handle+", 试题编号："+subjectId+", 试题分数"+score);
					}
				}
			} else {
				logger.error("添加试题 "+subjectId+" 到 Session 失败");
				response.getWriter().print("添加失败，试题编号或试题分数异常！");
				return;
			}
		} else {
			logger.error("需要添加的试题 "+subjectId+" 已经存在试卷 "+examPaperId+" 中了, 无法进行添加");
			//同时返回添加失败的题号，用于前台方便移除选中
			response.getWriter().print("f-exists-"+subjectId);
			return;
		}
		
		session.setAttribute("ids", ids);
		
		response.getWriter().print("编号为 "+subjectId+" 的试题添加成功");
	}
	
	/**
	 * 清空Session中保存的试题编号集合
	 * @param session
	 * @return
	 */
	@RequestMapping("/clearSubjectIdsWithSession")
	public String isClearChooseSubjectIds(HttpSession session) {
		logger.info("清空 Session 中需要添加的试题编号集合");
		session.removeAttribute("ids");
		
		return "redirect:examPapers";
	}
	
	
	/**
	 * 从试卷中移除试题
	 * @param subjectId 试题编号
	 * @param examPaperId 试卷百年好
	 * @param score 试题分数
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/removeSubjectFromPaper", method={RequestMethod.GET, RequestMethod.POST})
	public void removeSubjectWithExamPaper(
			@RequestParam("subjectId") Integer subjectId,
			@RequestParam("examPaperId") Integer examPaperId,
			@RequestParam("score") Integer score,
			HttpServletResponse response) throws IOException {
		logger.info("从试卷 "+examPaperId+" 中移除试题 "+subjectId+"，试题分值："+score);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("subjectNum", (-1));
		map.put("score", (-score));
		map.put("examPaperId", examPaperId);
		map.put("subjectId", subjectId);
		//修改试卷总分
		examPaperInfoService.isUpdateExamPaperScore(map);
		//修改试卷题目数量
		examPaperInfoService.isUpdateExamPaperSubjects(map);
		
		//从试卷中移除试题
		esmService.removeSubjectWithExamPaper(map);
		
		response.getWriter().print("t");
	}
	
	
	/**
	 * 自动生成试题到试卷
	 * @param examPaperId 试卷编号
	 * @param subjectEasy 试题难易程度
	 * @param courseId 科目编号
	 * @param gradeId 班级编号
	 * @param subjectSum 生成试题数量
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/autoAddSubject")
	public void isAutoAddSubjectToExamPaper(
			@RequestParam(value="examPaperId") Integer examPaperId,
			@RequestParam(value="subjectEasy", required=false) Integer subjectEasy,
			@RequestParam(value="courseId", required=false) Integer courseId,
			@RequestParam(value="gradeId", required=false) Integer gradeId,
			@RequestParam("subjectSum") Integer subjectSum,
			HttpServletResponse response) throws IOException {
		Random random = new Random();
		
		/*生成条件处理*/
		if (subjectEasy != null) {
			subject.setSubjectEasy(subjectEasy);
		}
		if (courseId != null) {
			course.setCourseId(courseId);
			subject.setCourse(course);
		}
		if (gradeId != null) {
			grade.setGradeId(gradeId);
			subject.setGrade(grade);
		}
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("subject", subject);
		map.put("startIndex", null);
		map.put("pageShow", null);
		
		List<SubjectInfo> subjects = subjectInfoService.getSubjects(map);
		int subjectTotal = subjects.size()-1;
		
		Map<String, Object> addMap = new HashMap<String, Object>();
		ArrayList<Integer> indexs = new ArrayList<Integer>();
		ArrayList<Integer> subjectIds = new ArrayList<Integer>();
		
		//添加试题总分
		int score = 0;
		for (int i=0; i<subjectSum; i++) {
			//产生随机索引
			int index = random.nextInt(subjectTotal);
			if (indexs.contains(index)) {  //随机索引已经存在
				i--;
				continue;
			} else {
				indexs.add(index);
				int subjectId = subjects.get(index).getSubjectId();
				subjectIds.add(subjectId);
				score += subjects.get(index).getSubjectScore();
				logger.info("索引 "+index+" 试题编号 "+subjectId+" 成立");
			}
		}
		
		//添加试题信息
		addMap.put("examPaperId", examPaperId);
		addMap.put("subjectIds", subjectIds);
		
		//总分和题目数量信息
		Map<String, Object> scoreWithNum = new HashMap<String, Object>();
		scoreWithNum.put("subjectNum", subjectSum);
		scoreWithNum.put("score", score);
		scoreWithNum.put("examPaperId", examPaperId);
		//修改试卷总分
		examPaperInfoService.isUpdateExamPaperScore(scoreWithNum);
		//修改试卷题目数量
		examPaperInfoService.isUpdateExamPaperSubjects(scoreWithNum);
		
		//添加
		logger.info("添加试题到试卷 "+examPaperId);
		esmService.isAddESM(addMap);
		
		response.getWriter().print("t");
	}
}
