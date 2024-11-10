package com.taohan.online.exam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.MapKey;
import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.ClassInfo;

/**
  *
  * <p>Title: ClassInfoMapper</p>
  * <p>Description: 班级信息代理接口</p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午2:08:29
  * @version: 1.0
  */

@Repository
public interface ClassInfoMapper {

	//获取班级信息集合
	public List<ClassInfo> getClasses(ClassInfo classInfo);
	
	//添加班级
	public int isAddClass(ClassInfo classInfo);
	
	//删除班级
	public int isDelClass(int classId);
	
	//根据班级编号获取班级信息
	public ClassInfo getClassById(int classId);
	
	//根据当前班级班主任编号获取当前班级信息
	public ClassInfo getClassByTeacherId(int teacherId);
	
	//修改班级信息
	public int isUpdateClass(ClassInfo classInfo);
	
	//获取指定班级下的班级集合
	public List<ClassInfo> getClassByGradeId(int gradeId);
	
	//获取各(指定班级下)班级下的员工总量
	//指定某一列的值作为 Map 的键
	@MapKey("className")
	public Map<String, Object> getStudentCountForClass(Integer gradeId);
}
