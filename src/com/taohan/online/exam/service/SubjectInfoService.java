package com.taohan.online.exam.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.taohan.online.exam.po.SubjectInfo;

/**
  *
  * <p>Title: SubjectInfoService</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 下午4:31:48
  * @version: 1.0
  */

@Repository
public interface SubjectInfoService {

	public List<SubjectInfo> getSubjects(Map<String, Object> map);
	
	public SubjectInfo getSubjectWithId(int subjectId);

	public int getSubjectTotal();

	public int isAddSubject(SubjectInfo subject);

	public int isUpdateSubject(SubjectInfo subject);

	public int isDelSubject(int subjectId);
	
	//批量添加试题
	public int isAddSubjects(Map<String, Object> map);
}
