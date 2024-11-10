package com.taohan.online.exam.po;

import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: ExamHistoryInfo</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-29
  * @time: 下午4:27:35
  * @version: 1.0
  */

@Component
public class ExamHistoryInfo {

	private Integer historyId;
	private StudentInfo student;
	private ExamPaperInfo examPaper;
	private int examScore;

	public Integer getHistoryId() {
		return historyId;
	}

	public void setHistoryId(Integer historyId) {
		this.historyId = historyId;
	}

	public StudentInfo getStudent() {
		return student;
	}

	public void setStudent(StudentInfo student) {
		this.student = student;
	}

	public ExamPaperInfo getExamPaper() {
		return examPaper;
	}

	public void setExamPaper(ExamPaperInfo examPaper) {
		this.examPaper = examPaper;
	}

	public int getExamScore() {
		return examScore;
	}

	public void setExamScore(int examScore) {
		this.examScore = examScore;
	}

	@Override
	public String toString() {
		return "ExamHistoryInfo [historyId=" + historyId + ", student="
				+ student + ", examPaper=" + examPaper + ", examScore="
				+ examScore + "]";
	}

}
