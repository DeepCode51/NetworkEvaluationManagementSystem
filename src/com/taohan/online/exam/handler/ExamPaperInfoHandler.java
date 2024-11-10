package com.taohan.online.exam.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.taohan.online.exam.po.ExamPaperInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.service.ExamPaperInfoService;
import com.taohan.online.exam.service.GradeInfoService;

/**
  *
  * <p>Title: ExamPaperInfoHandler</p>
  * <p>Description: 试卷</p>
  * @author: taohan
  * @date: 2018-8-16
  * @time: 下午4:35:43
  * @version: 1.0
  */

@Controller
@SuppressWarnings("all")
public class ExamPaperInfoHandler {

	@Autowired
	private ExamPaperInfoService examPaperInfoService;
	@Autowired
	private GradeInfoService gradeInfoService;
	@Autowired
	private GradeInfo grade;
	@Autowired
	private ExamPaperInfo examPaper;
	
	private Logger logger = Logger.getLogger(ExamPaperInfoHandler.class);
	
	
	/**
	 * 获取试卷信息
	 * @param gradeId 班级编号
	 * @param startPage 起始页 默认第一页
	 * @param pageShow 页容量 默认10
	 * @return
	 */
	@RequestMapping("/examPapers")
	public ModelAndView getCourses(@RequestParam(value = "gradeId", required = false) Integer gradeId,
			@RequestParam(value="startPage", required=false, defaultValue="1") Integer startPage,
			@RequestParam(value="pageShow", required=false, defaultValue="10") Integer pageShow ) {
		logger.info("获取试卷集合  gradeId="+gradeId+", startPage="+startPage+", pageShow="+pageShow);
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/examPapers");

		if (gradeId != null) {
			grade.setGradeId(gradeId);
			examPaper.setGrade(grade);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		//计算当前查询起始数据索引
		int startIndex = (startPage-1) * pageShow;
		map.put("examPaper", examPaper);
		map.put("startIndex", startIndex);
		map.put("pageShow", pageShow);
		List<ExamPaperInfo> examPapers = examPaperInfoService.getExamPapers(map);
		model.addObject("examPapers", examPapers);
		
		//获取试卷总量
		int examPaperTotal = examPaperInfoService.getExamPpaerTotal();
		//计算总页数
		int pageTotal = 1;
		if (examPaperTotal % pageShow == 0)
			pageTotal = examPaperTotal / pageShow;
		else
			pageTotal = examPaperTotal / pageShow + 1;			
		model.addObject("pageTotal", pageTotal);
		model.addObject("pageNow", startPage);

		return model;
	}

	/**
	 * 根据编号获取试卷信息
	 * @param examPaperId 试卷编号
	 * @return
	 */
	@RequestMapping("/examPaper/{examPaperId}")
	public ModelAndView getCourseById(@PathVariable("examPaperId") Integer examPaperId) {
		logger.info("获取试卷 " + examPaperId);
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/examPaperedit");

		ExamPaperInfo paper = examPaperInfoService.getExamPaper(examPaperId);
		model.addObject("examPaper", paper);
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);

		return model;
	}

	/**
	 * 添加/修改试卷信息
	 * @param examPaperId 待操作试卷编号
	 * @param isUpdate 标识是否为修改操作
	 * @param examPaperName 试卷名称
	 * @param subjectNum 试卷试题数量
	 * @param examPaperScore 试卷总分
	 * @param examPaperTime 试卷规定测评时间
	 * @param division 分类情况
	 * @param examPaperEasy 难易程度
	 * @param gradeId 班级编号
	 * @return
	 */
	@RequestMapping(value = "/examPaper/examPaper", method = RequestMethod.POST)
	public String isUpdateOrAddCourse(
			@RequestParam(value = "examPaperId", required = false) Integer examPaperId,
			@RequestParam(value = "isupdate", required = false) Integer isUpdate,
			@RequestParam(value = "examPaperName", required = false) String examPaperName,
			@RequestParam("subjectNum") Integer subjectNum,
			@RequestParam("examPaperScore") Integer examPaperScore,
			@RequestParam("examPaperTime") Integer examPaperTime,
			@RequestParam("division") Integer division,
			@RequestParam("examPaperEasy") Integer examPaperEasy,
			@RequestParam("gradeId") Integer gradeId) {

		examPaper.setExamPaperId(examPaperId);
		examPaper.setExamPaperName(examPaperName);
		examPaper.setSubjectNum(subjectNum);
		examPaper.setExamPaperScore(examPaperScore);
		examPaper.setExamPaperTime(examPaperTime);
		examPaper.setDivision(division);
		examPaper.setExamPaperEasy(examPaperEasy);
		grade.setGradeId(gradeId);
		examPaper.setGrade(grade);

		if (isUpdate != null) {
			logger.info("修改试卷 " + examPaper + " 的信息");
			int row = examPaperInfoService.isUpdateExamPaper(examPaper);
		} else {
			logger.info("添加试卷 " + examPaper + " 的信息");
			int row = examPaperInfoService.isAddExamPaper(examPaper);
		}

		return "redirect:/examPapers";
	}

	/**
	 * 删除试卷
	 * @param examPaperId 待删除试卷编号
	 * @return
	 */
	@RequestMapping(value = "/examPaper/{examPaperId}", method = RequestMethod.DELETE)
	public String isDelTeacher(@PathVariable("examPaperId") Integer examPaperId) {
		logger.info("删除试卷 " + examPaperId);

		int row = examPaperInfoService.isDelExamPaper(examPaperId);

		return "redirect:/examPapers";
	}

	/**
	 * 预添加试卷
	 * @return
	 */
	@RequestMapping("/preAddExamPaper")
	public ModelAndView preAddStudent() {
		logger.info("预添加试卷信息");
		ModelAndView model = new ModelAndView();
		model.setViewName("/admin/examPaperedit");
		List<GradeInfo> grades = gradeInfoService.getGrades();
		model.addObject("grades", grades);

		return model;
	}
}
