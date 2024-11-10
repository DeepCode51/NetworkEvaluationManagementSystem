package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ClassInfo;

/**
  *
  * <p>Title: ClassInfoService</p>
  * <p>Description: 班级信息 Service</p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午2:08:29
  * @version: 1.0
  */

@Repository
public interface ClassInfoService {

	// 获取班级集合
	public List<ClassInfo> getClasses(ClassInfo classInfo);

	// 添加班级
	public int isAddClass(ClassInfo classInfo);

	// 删除班级
	public int isDelClass(int classId);

	// 根据编号获取班级信息
	public ClassInfo getClassById(int classId);
	
	//根据当前班级班主任编号获取当前班级信息
	public ClassInfo getClassByTeacherId(int teacherId);

	// 修改班级信息
	public int isUpdateClass(ClassInfo classInfo);
	
	//获取指定班级下的班级集合
	public List<ClassInfo> getClassByGradeId(int gradeId);
	
	public Map<String, Object> getStudentCountForClass(Integer gradeId);
}
