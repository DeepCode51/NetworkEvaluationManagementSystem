package com.taohan.online.exam.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.StudentExamInfo;

/**
  *
  * <p>Title: StudentExamInfoMapper</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-9-19
  * @time: 上午10:07:04
  * @version: 1.0
  */

@Repository
public interface StudentExamInfoMapper {

	//后台HR根据查看某一班级下所有员工测评数量
	public List<StudentExamInfo> getStudentExamCountByClassId(int classId);
	
	//后台HR查看某一员工的测评信息
	public List<StudentExamInfo> getStudentExamInfo(int studentId);
	
	public List<StudentExamInfo> getAllStudentAvgScoreCount(int classId);
}
