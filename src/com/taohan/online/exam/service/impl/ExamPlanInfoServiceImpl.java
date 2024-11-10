package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.ExamPlanInfoMapper;
import com.taohan.online.exam.po.ExamPlanInfo;
import com.taohan.online.exam.service.ExamPlanInfoService;

/**
  *
  * <p>Title: ExamPlanInfoServiceImpl</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-22
  * @time: 下午4:06:02
  * @version: 1.0
  */

@Service
public class ExamPlanInfoServiceImpl implements ExamPlanInfoService {

	@Autowired
	private ExamPlanInfoMapper examPlanInfoMapper;
	
	public List<ExamPlanInfo> getExamPlans(Map<String, Object> map) {
		return examPlanInfoMapper.getExamPlans(map);
	}

	public int isAddExamPlan(ExamPlanInfo examPlan) {
		return examPlanInfoMapper.isAddExamPlan(examPlan);
	}

	public int isUpdateExamPlan(ExamPlanInfo examPlan) {
		return examPlanInfoMapper.isUpdateExamPlan(examPlan);
	}

	public ExamPlanInfo getExamPlanById(int examPlanId) {
		return examPlanInfoMapper.getExamPlanById(examPlanId);
	}

	//查询员工待考信息
	public List<ExamPlanInfo> getStudentWillExam(Map<String, Object> map) {
		return examPlanInfoMapper.getStudentWillExam(map);
	}

	//移除过期测评安排
	public int isRemoveExamPlan(int examPlanId) {
		return examPlanInfoMapper.isRemoveExamPlan(examPlanId);
	}

}
