package com.taohan.online.exam.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.TeacherInfo;

/**
  *
  * <p>Title: TeacherInfoMapper</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午3:14:13
  * @version: 1.0
  */

@Repository
public interface TeacherInfoMapper {

	//获取HR集合
	//public List<TeacherInfo> getTeachers(TeacherInfo teacher);
	public List<TeacherInfo> getTeachers(Map<String, Object> map);
	
	//根据HR账户获取HR信息
	public TeacherInfo getTeacherByAccount(String teacherAccount);
	
	//获取HR数据总量
	public int getTeacherTotal();
	
	//修改HR班主任状态
	public int updateTeacherIsWork(TeacherInfo teacherInfo);
	
	//根据HR编号获取HR信息
	public TeacherInfo getTeacherById(int teacherId);
	
	//修改HR信息
	public int isUpdateTeacherInfo(TeacherInfo teacher);
	
	//添加HR信息
	public int isAddTeacherInfo(TeacherInfo teacher);
	
	//删除HR信息
	public int isDelTeacherInfo(int teacherId);
}
