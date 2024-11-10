package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ExamPaperInfo;

/**
  *
  * <p>Title: ExamPaperInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-16
  * @time: 下午4:31:32
  * @version: 1.0
  */

@Repository
public interface ExamPaperInfoService {

	public List<ExamPaperInfo> getExamPapers(Map<String, Object> map);

	public ExamPaperInfo getExamPaper(int examPaperId);
	
	public List<ExamPaperInfo> getExamPapersClear();

	public int isAddExamPaper(ExamPaperInfo examPaper);

	public int isUpdateExamPaper(ExamPaperInfo examPaper);

	public int isDelExamPaper(int examPaperId);
	
	public int getExamPpaerTotal();
	
	public int isUpdateExamPaperSubjects(Map<String, Object> map);
	
	public int isUpdateExamPaperScore(Map<String, Object> map);
}
