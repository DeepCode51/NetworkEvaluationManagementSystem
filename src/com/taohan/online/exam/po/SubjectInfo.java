package com.taohan.online.exam.po;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: SubjectInfo</p>
  * <p>Description: 试题实体类</p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 下午3:47:45
  * @version: 1.0
  */

@Component
@Scope("prototype")
@SuppressWarnings("serial")
public class SubjectInfo implements Serializable {

	private Integer subjectId;
	private String subjectName;
	private String optionA;
	private String optionB;
	private String optionC;
	private String optionD;
	private String rightResult;
	private int subjectScore;
	private int subjectType;
	private int subjectEasy;
	private int division;
	private CourseInfo course;
	private GradeInfo grade;

	public Integer getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getRightResult() {
		return rightResult;
	}

	public void setRightResult(String rightResult) {
		this.rightResult = rightResult;
	}

	public int getSubjectScore() {
		return subjectScore;
	}

	public void setSubjectScore(int subjectScore) {
		this.subjectScore = subjectScore;
	}

	public int getSubjectType() {
		return subjectType;
	}

	public void setSubjectType(int subjectType) {
		this.subjectType = subjectType;
	}

	public int getSubjectEasy() {
		return subjectEasy;
	}

	public void setSubjectEasy(int subjectEasy) {
		this.subjectEasy = subjectEasy;
	}

	public int getDivision() {
		return division;
	}

	public void setDivision(int division) {
		this.division = division;
	}

	public CourseInfo getCourse() {
		return course;
	}

	public void setCourse(CourseInfo course) {
		this.course = course;
	}

	public GradeInfo getGrade() {
		return grade;
	}

	public void setGrade(GradeInfo grade) {
		this.grade = grade;
	}

	public SubjectInfo(Integer subjectId, String subjectName, String optionA,
			String optionB, String optionC, String optionD, String rightResult,
			int subjectScore, int subjectType, int subjectEasy, int division,
			CourseInfo course, GradeInfo grade) {
		super();
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.optionA = optionA;
		this.optionB = optionB;
		this.optionC = optionC;
		this.optionD = optionD;
		this.rightResult = rightResult;
		this.subjectScore = subjectScore;
		this.subjectType = subjectType;
		this.subjectEasy = subjectEasy;
		this.division = division;
		this.course = course;
		this.grade = grade;
	}

	public SubjectInfo() {
		super();
	}

	@Override
	public String toString() {
		return "SubjectInfo [subjectId=" + subjectId + ", subjectName="
				+ subjectName + ", optionA=" + optionA + ", optionB=" + optionB
				+ ", optionC=" + optionC + ", optionD=" + optionD
				+ ", rightResult=" + rightResult + ", subjectScore="
				+ subjectScore + ", subjectType=" + subjectType
				+ ", subjectEasy=" + subjectEasy + ", division=" + division
				+ ", course=" + course + ", grade=" + grade + "]";
	}

}
