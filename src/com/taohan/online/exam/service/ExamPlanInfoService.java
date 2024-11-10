package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ExamPlanInfo;

/**
  *
  * <p>Title: ExamPlanInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-22
  * @time: 下午4:05:30
  * @version: 1.0
  */

@Repository
public interface ExamPlanInfoService {

	public List<ExamPlanInfo> getExamPlans(Map<String, Object> map);
	
	public int isAddExamPlan(ExamPlanInfo examPlan);

	public int isUpdateExamPlan(ExamPlanInfo examPlan);
	
	public ExamPlanInfo getExamPlanById(int examPlanId);
	
	//查询员工待考信息
	public List<ExamPlanInfo> getStudentWillExam(Map<String, Object> map);
	
	public int isRemoveExamPlan(int examPlanId);
}
