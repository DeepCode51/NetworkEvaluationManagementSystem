package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.ExamHistoryPaperMapper;
import com.taohan.online.exam.po.ExamHistoryInfo;
import com.taohan.online.exam.po.ExamHistoryPaper;
import com.taohan.online.exam.service.ExamHistoryPaperService;

/**
  *
  * <p>Title: ExamHistoryPaperServiceImpl</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-29
  * @time: 下午4:46:13
  * @version: 1.0
  */

@Service
public class ExamHistoryPaperServiceImpl implements ExamHistoryPaperService {

	@Autowired
	private ExamHistoryPaperMapper examHistoryPaperMapper;
	
	public List<ExamHistoryPaper> getExamHistoryToStudent(int studentId) {
		return examHistoryPaperMapper.getExamHistoryToStudent(studentId);
	}

	public int isAddExamHistory(Map<String, Object> map) {
		return examHistoryPaperMapper.isAddExamHistory(map);
	}

	public int getHistoryInfoWithIds(Map<String, Object> map) {
		return examHistoryPaperMapper.getHistoryInfoWithIds(map);
	}

	public List<ExamHistoryInfo> getExamHistoryToTeacher() {
		return examHistoryPaperMapper.getExamHistoryToTeacher();
	}

}
