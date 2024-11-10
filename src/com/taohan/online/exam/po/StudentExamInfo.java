package com.taohan.online.exam.po;

import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: StudentExamInfo</p>
  * <p>Description: 员工测评信息  主要用于前台图表绘制 数据封装</p>
  * @author: taohan
  * @date: 2018-9-19
  * @time: 上午9:56:29
  * @version: 1.0
  */

@Component
public class StudentExamInfo {

	private Integer studentId;
	private String studentName;
	private Integer examSum;
	private Integer avgScore;
	public Integer getAvgScore() {
		return avgScore;
	}

	public void setAvgScore(Integer avgScore) {
		this.avgScore = avgScore;
	}

	private Integer examScore;
	private String examPaperName;
	private Integer examPaperScore;

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

	public Integer getExamSum() {
		return examSum;
	}

	public void setExamSum(Integer examSum) {
		this.examSum = examSum;
	}

	public Integer getExamScore() {
		return examScore;
	}

	public void setExamScore(Integer examScore) {
		this.examScore = examScore;
	}

	public String getExamPaperName() {
		return examPaperName;
	}

	public void setExamPaperName(String examPaperName) {
		this.examPaperName = examPaperName;
	}

	public Integer getExamPaperScore() {
		return examPaperScore;
	}

	public void setExamPaperScore(Integer examPaperScore) {
		this.examPaperScore = examPaperScore;
	}

	@Override
	public String toString() {
		return "StudentExamInfo [studentId=" + studentId + ", studentName="
				+ studentName + ", examSum=" + examSum + ", examScore="
				+ examScore + ", examPaperName=" + examPaperName
				+ ", examPaperScore=" + examPaperScore + "]";
	}

}
