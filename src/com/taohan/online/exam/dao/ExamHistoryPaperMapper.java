package com.taohan.online.exam.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ExamHistoryInfo;
import com.taohan.online.exam.po.ExamHistoryPaper;

/**
  *
  * <p>Title: ExamHistoryPaperMapper</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-29
  * @time: 下午4:44:07
  * @version: 1.0
  */

@Repository
public interface ExamHistoryPaperMapper {

	//查询测评历史信息，针对前台员工查询
	public List<ExamHistoryPaper> getExamHistoryToStudent(int studentId);
	
	public int isAddExamHistory(Map<String, Object> map);
	
	public int getHistoryInfoWithIds(Map<String, Object> map);
	
	//查询测评历史信息，针对后台HR查询
	public List<ExamHistoryInfo> getExamHistoryToTeacher();
}
