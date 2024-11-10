package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.ClassInfoMapper;
import com.taohan.online.exam.po.ClassInfo;
import com.taohan.online.exam.service.ClassInfoService;

/**
  *
  * <p>Title: ClassInfoServiceImpl</p>
  * <p>Description: 班级信息 Service 实现类</p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午2:16:32
  * @version: 1.0
  */

@Service
public class ClassInfoServiceImpl implements ClassInfoService {

	@Autowired
	private ClassInfoMapper classInfoMapper;
	
	//获取班级集合
	public List<ClassInfo> getClasses(ClassInfo classInfo) {
		return classInfoMapper.getClasses(classInfo);
	}

	//添加班级
	public int isAddClass(ClassInfo classInfo) {
		return classInfoMapper.isAddClass(classInfo);
	}

	//删除班级
	public int isDelClass(int classId) {
		return classInfoMapper.isDelClass(classId);
	}

	public ClassInfo getClassById(int classId) {
		return classInfoMapper.getClassById(classId);
	}

	public int isUpdateClass(ClassInfo classInfo) {
		return classInfoMapper.isUpdateClass(classInfo);
	}

	//获取指定班级下的班级
	public List<ClassInfo> getClassByGradeId(int gradeId) {
		return classInfoMapper.getClassByGradeId(gradeId);
	}

	//获取各(指定班级下)班级下的员工总量
	public Map<String, Object> getStudentCountForClass(Integer gradeId) {
		return classInfoMapper.getStudentCountForClass(gradeId);
	}

	//根据当前班级班主任编号获取当前班级信息
	public ClassInfo getClassByTeacherId(int teacherId) {
		return classInfoMapper.getClassByTeacherId(teacherId);
	}

}
