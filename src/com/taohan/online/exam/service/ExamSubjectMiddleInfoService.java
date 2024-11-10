package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ExamSubjectMiddleInfo;

/**
  *
  * <p>Title: ExamSubjectMiddleInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-20
  * @time: 下午4:16:54
  * @version: 1.0
  */

@Repository
public interface ExamSubjectMiddleInfoService {
	
	public List<ExamSubjectMiddleInfo> getExamPaperWithSubject(ExamSubjectMiddleInfo esm);

	public int isAddESM(Map<String, Object> map);
	
	public int removeSubjectWithExamPaper(Map<String, Object> map);
	
	public Integer getEsmByExamIdWithSubjectId(ExamSubjectMiddleInfo esm);
}
