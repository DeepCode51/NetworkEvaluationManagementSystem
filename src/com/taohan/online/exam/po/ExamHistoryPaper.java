package com.taohan.online.exam.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: ExamHistoryPaper</p>
  * <p>Description: 扩展类，用于封装历史测评信息、试卷信息、测评时间</p>
  * @author: taohan
  * @date: 2018-8-29
  * @time: 下午4:41:22
  * @version: 1.0
  */

@Component
@Scope("prototype")
public class ExamHistoryPaper {

	// 试卷得分
	private int examScore;

	// 测评时间
	private String beginTime;

	private Integer examPaperId;
	private String examPaperName;
	private int subjectNum;
	private int examPaperScore;

	public int getExamScore() {
		return examScore;
	}

	public void setExamScore(int examScore) {
		this.examScore = examScore;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public Integer getExamPaperId() {
		return examPaperId;
	}

	public void setExamPaperId(Integer examPaperId) {
		this.examPaperId = examPaperId;
	}

	public String getExamPaperName() {
		return examPaperName;
	}

	public void setExamPaperName(String examPaperName) {
		this.examPaperName = examPaperName;
	}

	public int getSubjectNum() {
		return subjectNum;
	}

	public void setSubjectNum(int subjectNum) {
		this.subjectNum = subjectNum;
	}

	public int getExamPaperScore() {
		return examPaperScore;
	}

	public void setExamPaperScore(int examPaperScore) {
		this.examPaperScore = examPaperScore;
	}

}
