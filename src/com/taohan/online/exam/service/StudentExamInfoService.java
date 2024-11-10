package com.taohan.online.exam.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.StudentExamInfo;

/**
  *
  * <p>Title: StudentExamInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-9-19
  * @time: 上午10:08:46
  * @version: 1.0
  */

@Repository
public interface StudentExamInfoService {

	//后台HR根据查看某一班级下所有员工测评数量
	public List<StudentExamInfo> getStudentExamCountByClassId(int classId);
	
	//后台HR查看某一员工的测评信息
	public List<StudentExamInfo> getStudentExamInfo(int studentId);
	
	//后台HR查看指定班级中所有员工的平均成绩以及测评次数
	public List<StudentExamInfo> getAllStudentAvgScoreCount(int classId);
}
