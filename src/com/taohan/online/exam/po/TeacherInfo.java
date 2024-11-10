package com.taohan.online.exam.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: TeacherInfo</p>
  * <p>Description: HR实体类</p>
  * @author: taohan
  * @date: 2018-8-13
  * @time: 下午2:02:46
  * @version: 1.0
  */

@Component
@Scope("prototype")
public class TeacherInfo {

	private Integer teacherId;
	private String teacherName;
	private String teacherAccount;
	private String teacherPwd;
	private int adminPower;
	private Integer isWork;
	private ClassInfo classInfo;

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getTeacherAccount() {
		return teacherAccount;
	}

	public void setTeacherAccount(String teacherAccount) {
		this.teacherAccount = teacherAccount;
	}

	public String getTeacherPwd() {
		return teacherPwd;
	}

	public void setTeacherPwd(String teacherPwd) {
		this.teacherPwd = teacherPwd;
	}

	public int getAdminPower() {
		return adminPower;
	}

	public void setAdminPower(int adminPower) {
		this.adminPower = adminPower;
	}

	public Integer getIsWork() {
		return isWork;
	}

	public void setIsWork(Integer isWork) {
		this.isWork = isWork;
	}

	public ClassInfo getClassInfo() {
		return classInfo;
	}

	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}

	@Override
	public String toString() {
		return "TeacherInfo [teacherId=" + teacherId + ", teacherName="
				+ teacherName + ", teacherAccount=" + teacherAccount
				+ ", teacherPwd=" + teacherPwd + ", adminPower=" + adminPower
				+ ", isWork=" + isWork + "]";
	}

}
