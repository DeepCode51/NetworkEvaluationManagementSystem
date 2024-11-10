package com.taohan.online.exam.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.GradeInfo;

/**
  *
  * <p>Title: GradeInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-14
  * @time: 上午9:56:49
  * @version: 1.0
  */

@Repository
public interface GradeInfoService {

	//获取所有班级
	public List<GradeInfo> getGrades();
	
	//根据编号获取班级
	public GradeInfo getGradeById(int gradeId);
	
	//添加班级
	public int isAddGrade(GradeInfo grade);
	
	//删除班级
	public int isDelGrade(int gradeId);
	
	//修改班级
	public int isUpdateGrade(GradeInfo grade);
}
