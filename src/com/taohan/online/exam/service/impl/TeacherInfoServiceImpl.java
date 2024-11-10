package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.TeacherInfoMapper;
import com.taohan.online.exam.po.TeacherInfo;
import com.taohan.online.exam.service.TeacherInfoService;

/**
  *
  * <p>Title: TeacherInfoServiceImpl</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午3:16:25
  * @version: 1.0
  */

@Service
public class TeacherInfoServiceImpl implements TeacherInfoService {

	@Autowired
	private TeacherInfoMapper teacherInfoMapper;

	/*
	 * public List<TeacherInfo> getTeachers(TeacherInfo teacher) { return
	 * teacherInfoMapper.getTeachers(teacher); }
	 */

	public TeacherInfo getTeacherByAccount(String teacherAccount) {
		return teacherInfoMapper.getTeacherByAccount(teacherAccount);
	}

	public int updateTeacherIsWork(TeacherInfo teacherInfo) {
		return teacherInfoMapper.updateTeacherIsWork(teacherInfo);
	}

	public TeacherInfo getTeacherById(int teacherId) {
		return teacherInfoMapper.getTeacherById(teacherId);
	}

	public int isUpdateTeacherInfo(TeacherInfo teacher) {
		return teacherInfoMapper.isUpdateTeacherInfo(teacher);
	}

	public int isAddTeacherInfo(TeacherInfo teacher) {
		return teacherInfoMapper.isAddTeacherInfo(teacher);
	}

	public int isDelTeacherInfo(int teacherId) {
		return teacherInfoMapper.isDelTeacherInfo(teacherId);
	}

	public List<TeacherInfo> getTeachers(Map<String, Object> map) {
		return teacherInfoMapper.getTeachers(map);
	}

	public int getTeacherTotal() {
		return teacherInfoMapper.getTeacherTotal();
	}

}
