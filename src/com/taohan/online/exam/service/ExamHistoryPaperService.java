package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ExamHistoryInfo;
import com.taohan.online.exam.po.ExamHistoryPaper;

/**
  *
  * <p>Title: ExamHistoryPaperService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-29
  * @time: 下午4:45:27
  * @version: 1.0
  */

@Repository
public interface ExamHistoryPaperService {

	//查询测评历史信息，针对前台员工查询
	public List<ExamHistoryPaper> getExamHistoryToStudent(int studentId);
	
	public int isAddExamHistory(Map<String, Object> map);
	
	public int getHistoryInfoWithIds(Map<String, Object> map);
	
	public List<ExamHistoryInfo> getExamHistoryToTeacher();
}
