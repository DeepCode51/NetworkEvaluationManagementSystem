package com.taohan.online.exam.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import th.uploadeasy.SaveFileDispose;

import com.taohan.online.exam.po.CourseInfo;
import com.taohan.online.exam.po.ExamPaperInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.po.SubjectInfo;
import com.taohan.online.exam.service.CourseInfoService;
import com.taohan.online.exam.service.ExamPaperInfoService;
import com.taohan.online.exam.service.ExamSubjectMiddleInfoService;
import com.taohan.online.exam.service.GradeInfoService;
import com.taohan.online.exam.service.SubjectInfoService;
import com.taohan.online.exam.util.SubjectImportUtil;

/**
  *
  * <p>Title: SubjectInfoHandler</p>
  * <p>Description: 试题</p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 下午4:33:48
  * @version: 1.0
  */

@Controller
@SuppressWarnings("all")
public class SubjectInfoHandler {

	@Autowired
	private SubjectInfoService subjectInfoService;
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private GradeInfoService gradeInfoService;
	@Autowired
	private ExamPaperInfoService examPaperInfoService;
	@Autowired
	private ExamSubjectMiddleInfoService esmService;
	@Autowired
	private SubjectInfo subject;
	@Autowired
	private CourseInfo course;
	@Autowired
	private GradeInfo grade;
	@Autowired
	private ExamPaperInfo examPaper;
	
	private Logger logger = Logger.getLogger(SubjectInfoHandler.class);
	
	
	/**
	 * 查询试题集合
	 * @param subjectId    查询条件
	 * @param courseId
	 * @param gradeId
	 * @param startPage
	 * @param pageShow
	 * @param handAdd  标识 是否为需要进行手动添加试题到试卷而发起的请求
	 * @param examPaperId
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/subjects", method=RequestMethod.GET)
	public ModelAndView getTeachers(
			@RequestParam(value="subjectId", required=false) Integer subjectId,
			@RequestParam(value="courseId", required=false) Integer courseId,
			@RequestParam(value="gradeId", required=false) Integer gradeId,
			@RequestParam(value="startPage", required=false, defaultValue="1") Integer startPage,
			@RequestParam(value="pageShow", required=false, defaultValue="10") Integer pageShow,
			@RequestParam(value="handAdd", required=false) Integer handAdd,
			@RequestParam(value="examPaperId", required=false) Integer examPaperId,
			HttpSession session) {
		logger.info("查询试题集合");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("admin/subjects");
		
		//条件处理
		if (subjectId != null) subject.setSubjectId(subjectId);
		if (courseId != null) course.setCourseId(courseId);
		if (gradeId != null) grade.setGradeId(gradeId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		//计算当前查询起始数据索引
		int startIndex = (startPage-1) * pageShow;
		//map.put("subject", subject);
		map.put("startIndex", startIndex);
		map.put("pageShow", pageShow);
		List<SubjectInfo> subjects = subjectInfoService.getSubjects(map);
		model.addObject("subjects", subjects);
		
		//获取试题总量
		int subjectTotal = subjectInfoService.getSubjectTotal();
		//计算总页数
		int pageTotal = 1;
		if (subjectTotal % pageShow == 0)
			pageTotal = subjectTotal / pageShow;
		else
			pageTotal = subjectTotal / pageShow + 1;			
		model.addObject("pageTotal", pageTotal);
		model.addObject("pageNow", startPage);
		
		//是否为需要进行手动添加试题到试卷而发起的请求
		if (handAdd != null && handAdd == 1) {
			model.addObject("handAdd", "1");
		}
		//如果是手动添加试题到试卷，则需要返回试卷编号, 且返回当前已经选择试题数量
		if (examPaperId != null) {
			model.addObject("examPaperId", examPaperId);
			List<String> ids = (List<String>) session.getAttribute("ids");
			if (ids == null) {
				model.addObject("choosed", 0);
			} else {				
				model.addObject("choosed", ids.size());
			}
		}
		
		return model;
	}
	
	
	/**
	 * 添加试题
	 * @param subject
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/addSubject", method=RequestMethod.POST)
	public void addSubject(SubjectInfo subject, HttpServletResponse response) throws IOException {
		if(subject != null){
			subject.setSubjectName(trimChar(subject.getSubjectName()));
			subject.setRightResult(trimChar(subject.getRightResult()));
			subject.setOptionA(trimChar(subject.getOptionA()));
			subject.setOptionB(trimChar(subject.getOptionB()));
			subject.setOptionC(trimChar(subject.getOptionC()));
			subject.setOptionD(trimChar(subject.getOptionD()));
		}
		int row = subjectInfoService.isAddSubject(subject);
		
		response.getWriter().print("试题添加成功!");
	}
	
	
	/**
	 * 删除试题
	 * @param subjectId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delSubject", method=RequestMethod.POST)
	public void delSubject(@RequestParam("subjectId") Integer subjectId,
			HttpServletResponse response) throws IOException {
		logger.info("删除试题 "+subjectId);
		
		int row = subjectInfoService.isDelSubject(subjectId);
		
		if (row > 0) {
			response.getWriter().print("t");
		} else {
			response.getWriter().print("f");			
		}
	}
	
	
	/**
	 * 修改试题 -- 获取待修改试题信息
	 * @param subjectId
	 * @return
	 */
	@RequestMapping("/subject/{subjectId}")
	public ModelAndView updateSubject(@PathVariable("subjectId") Integer subjectId) {
		logger.info("修改试题 "+subjectId+" 的信息(获取试题信息)");
		
		SubjectInfo subject = subjectInfoService.getSubjectWithId(subjectId);
		
		ModelAndView model = new ModelAndView("/admin/subject-test");
		model.addObject("subject", subject);
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);
		model.addObject("courses", courseInfoService.getCourses(null));
		return model;
	}
	
	/**
	 * 修改试题
	 * @param subject
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/updateSubject", method=RequestMethod.POST)
	public void updateSubject(SubjectInfo subject, HttpServletResponse response) throws IOException {
		logger.info("修改试题 "+subject.getSubjectId()+" 的信息(正式)");

		if(subject != null){
			subject.setSubjectName(trimChar(subject.getSubjectName()));
			subject.setRightResult(trimChar(subject.getRightResult()));
			subject.setOptionA(trimChar(subject.getOptionA()));
			subject.setOptionB(trimChar(subject.getOptionB()));
			subject.setOptionC(trimChar(subject.getOptionC()));
			subject.setOptionD(trimChar(subject.getOptionD()));
		}
		int row = subjectInfoService.isUpdateSubject(subject);
		if (row > 0) {
			response.getWriter().print("试题修改成功!");
		} else {
			response.getWriter().print("试题修改失败!");
		}
	}
	
	
	/**
	 * 初始化 导入 excel 试题信息
	 * @return
	 */
	@RequestMapping(value="/initImport")
	public ModelAndView initImportExcel() {
		logger.info("初始化 导入 EXCEL 试题信息");
		ModelAndView model = new ModelAndView("admin/importSubject");
		//获取所有科目
		List<CourseInfo> courses = courseInfoService.getCourses(null);
		//获取所有班级
		List<GradeInfo> grades = gradeInfoService.getGrades();
		//获取所有试卷名称
		List<ExamPaperInfo> examPapers = examPaperInfoService.getExamPapersClear();
		
		model.addObject("courses", courses);
		model.addObject("grades", grades);
		model.addObject("examPapers", examPapers);
		
		return model;
	}
	
	
	/**
	 * 试题导入 处理
	 * @param request
	 * @param importOption
	 * @param excel
	 */
	@RequestMapping(value="/dispatcherUpload", method=RequestMethod.POST)
	public ModelAndView dispatcherUpload(HttpServletRequest request,
			@RequestParam("division") Integer division,
			@RequestParam("courseId") Integer courseId,
			@RequestParam("gradeId") Integer gradeId,
			@RequestParam("examPaperId") Integer examPaperId,
			@RequestParam("importOption") String importOption,
			@RequestParam("examPaperEasy") Integer examPaperEasy,
			@RequestParam("examPaperName") String examPaperName,
			@RequestParam("examPaperTime") Integer examPaperTime,
			@RequestParam("inputfile") MultipartFile excel) {
		ModelAndView model = new ModelAndView("reception/suc");
		String savePath = "";
		
		try {
			/** 保存上传 excel 文件 */
			savePath = saveUploadFile(excel, request.getRealPath("/WEB-INF/upload"));
			
			/** 解析上传 excel 文件, 得到试题集合 */
			List<SubjectInfo> subjects = SubjectImportUtil.parseSubjectExcel(savePath, courseId, gradeId, division);
			
			/** 只添加试题 */
			if ("0".equals(importOption)) {
				Map<String, Object> subjectsMap = new HashMap<String, Object>();
				subjectsMap.put("subjects", subjects);
				
				importSubejctOnly(subjects, subjectsMap);
			}
			/** 添加试题到指定的已有试卷 */
			else if ("1".equals(importOption)) {
				dispatcherExamPaperAndSubject(subjects, examPaperId);
			}
			/** 添加试题到新建试卷 */
			else if ("2".equals(importOption)) {
				/** 创建新试卷 */
				examPaper.setExamPaperName(examPaperName);
				examPaper.setExamPaperEasy(examPaperEasy);
				examPaper.setExamPaperTime(examPaperTime);
				grade.setGradeId(gradeId);
				examPaper.setGrade(grade);
				examPaper.setDivision(division);
				int row = examPaperInfoService.isAddExamPaper(examPaper);
				logger.info("添加的新试卷 编号 "+examPaper.getExamPaperId());
				
				dispatcherExamPaperAndSubject(subjects, examPaper.getExamPaperId());
			}
			
			if (subjects.size() == 0) {
				model.addObject("success", "操作处理失败，共添加 <b style='color:red;'>"+subjects.size()+"</b> 道题, 请检查上传数据正确性!");
			} else {
				model.addObject("success", "操作处理成功，共添加 "+subjects.size()+" 道题");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			model.setViewName("error");
			model.addObject("error", "上传失败, 请检查上传数据合理性或联系管理员!");
		} finally {
			/** 删除上传文件 */
			deleteUploadFile(savePath);
		}
		return model;
	}
	
	
	/**
	 * 保存上传 excel 文件
	 * @param file 上传文件
	 * @return 保存路径
	 */
	private String saveUploadFile(MultipartFile file, String rootPath) {
		String fileName = file.getOriginalFilename();
		logger.info("保存上传文件 "+fileName+" 到 "+rootPath);
		
		try {
			file.transferTo(new File(rootPath+"/"+fileName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return rootPath+"/"+fileName;
	}
	
	
	/**
	 * 只将试题上传到数据库
	 * @param subjects
	 * @param subjectsMap
	 */
	private void importSubejctOnly(List<SubjectInfo> subjects, Map<String, Object> subjectsMap) {
		try {
			if (subjects != null && subjects.size() > 0) {
				//添加试题
				int row = subjectInfoService.isAddSubjects(subjectsMap);
				logger.info("只将 excel 中的试题添加到数据库成功 SIZE "+subjects.size());
			} else {
				logger.info("上传试题文件中不存在试题，或解析失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 处理 试题 添加到 试卷
	 * @param subjects 试题集合
	 * @param examPaperId 对应试卷编号
	 */
	private void dispatcherExamPaperAndSubject(List<SubjectInfo> subjects, Integer examPaperId) {
		List<Integer> subjectIds = new ArrayList<Integer>();
		//试题总量统计
		int count = 0;
		//试题总分统计
		int score = 0;
		
		/** 添加试题 */
		for (SubjectInfo subjectInfo : subjects) {
			int row1 = subjectInfoService.isAddSubject(subjectInfo);
			score += subjectInfo.getSubjectScore();
			subjectIds.add(subjectInfo.getSubjectId());
			count++;
		}
		logger.info("添加试题 SIZE "+count);
		
		/** 添加试题到试卷 */
		Map<String, Object> esmMap = new HashMap<String, Object>();
		esmMap.put("examPaperId", examPaperId);
		esmMap.put("subjectIds", subjectIds);
		esmService.isAddESM(esmMap);
		logger.info("添加试题 SIZE "+count+" SCORE "+score+" 到试卷 "+examPaperId);
		
		//修改试卷信息
		Map<String, Object> scoreWithNum = new HashMap<String, Object>();
		scoreWithNum.put("subjectNum", count);
		scoreWithNum.put("score", score);
		scoreWithNum.put("examPaperId", examPaperId);
		/** 修改试卷总分 */
		examPaperInfoService.isUpdateExamPaperScore(scoreWithNum);
		/** 修改试卷试题总量 */
		examPaperInfoService.isUpdateExamPaperSubjects(scoreWithNum);
	}
	
	
	/**
	 * 删除上传文件
	 * @param filePath 文件路径
	 */
	private void deleteUploadFile(String filePath) {
		File file = new File(filePath);
		
		if (file.exists()) {
			file.delete();
			logger.info("上传文件已被删除 "+filePath);
		}
	}
	
	/**
	 * 预添加试题
	 * @return
	 */
	@RequestMapping("/preAddSubject")
	public ModelAndView preAddStudent() {
		logger.info("预添加试卷信息");
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/subject-test");
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);
		model.addObject("courses", courseInfoService.getCourses(null));
		return model;
	}
	
	private String trimChar(String str){
		if(str != null){
			return str.replaceAll("^,*|,*$", "");
		}
		return str;
	}
	
}
