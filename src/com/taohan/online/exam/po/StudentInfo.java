package com.taohan.online.exam.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: StudentInfo</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-16
  * @time: 上午9:42:49
  * @version: 1.0
  */

@Component
@Scope("prototype")
public class StudentInfo {

	private Integer studentId;
	private String studentName;
	private String studentAccount;
	private String studentPwd;
	private ClassInfo classInfo;
	private GradeInfo grade;

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getStudentAccount() {
		return studentAccount;
	}

	public void setStudentAccount(String studentAccount) {
		this.studentAccount = studentAccount;
	}

	public String getStudentPwd() {
		return studentPwd;
	}

	public void setStudentPwd(String studentPwd) {
		this.studentPwd = studentPwd;
	}

	public ClassInfo getClassInfo() {
		return classInfo;
	}

	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}

	public GradeInfo getGrade() {
		return grade;
	}

	public void setGrade(GradeInfo grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "StudentInfo [studentId=" + studentId + ", studentName="
				+ studentName + ", studentAccount=" + studentAccount
				+ ", studentPwd=" + studentPwd + ", classInfo=" + classInfo
				+ ", grade=" + grade + "]";
	}
}
