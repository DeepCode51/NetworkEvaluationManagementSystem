package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.ExamPaperInfoMapper;
import com.taohan.online.exam.po.ExamPaperInfo;
import com.taohan.online.exam.service.ExamPaperInfoService;

/**
  *
  * <p>Title: ExamPaperServiceImpl</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-16
  * @time: 下午4:32:01
  * @version: 1.0
  */

@Service
public class ExamPaperServiceImpl implements ExamPaperInfoService {
	
	@Autowired
	private ExamPaperInfoMapper examPaperInfoMapper;
	
	private Logger logger = Logger.getLogger(ExamPaperServiceImpl.class);

	public List<ExamPaperInfo> getExamPapers(Map<String, Object> map) {
		return examPaperInfoMapper.getExamPapers(map);
	}

	public ExamPaperInfo getExamPaper(int examPaperId) {
		return examPaperInfoMapper.getExamPaperById(examPaperId);
	}

	public int isAddExamPaper(ExamPaperInfo examPaper) {
		return examPaperInfoMapper.isAddExamPaper(examPaper);
	}

	public int isUpdateExamPaper(ExamPaperInfo examPaper) {
		return examPaperInfoMapper.isUpdateExamPaper(examPaper);
	}

	public int isDelExamPaper(int examPaperId) {
		return examPaperInfoMapper.isDelExamPaper(examPaperId);
	}

	public int getExamPpaerTotal() {
		return examPaperInfoMapper.getExamPpaerTotal();
	}

	public int isUpdateExamPaperSubjects(Map<String, Object> map) {
		logger.info("修改试卷 "+map.get("examPaperId")+"的题目数量，变动数量："+map.get("subjectNum"));
		return examPaperInfoMapper.isUpdateExamPaperSubjects(map);
	}

	public int isUpdateExamPaperScore(Map<String, Object> map) {
		logger.info("修改试卷 "+map.get("examPaperId")+"的总分，变动分值："+map.get("score"));
		return examPaperInfoMapper.isUpdateExamPaperScore(map);
	}

	public List<ExamPaperInfo> getExamPapersClear() {
		return examPaperInfoMapper.getExamPapersClear();
	}

}
