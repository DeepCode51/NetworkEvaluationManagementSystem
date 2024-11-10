package com.taohan.online.exam.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
  *
  * <p>Title: ExamPlanInfo</p>
  * <p>Description: 测评安排记录</p>
  * @author: taohan
  * @date: 2018-8-22
  * @time: 下午2:55:38
  * @version: 1.0
  */

@Component
@Scope("prototype")
public class ExamPlanInfo {

	private Integer examPlanId;
	private CourseInfo course;
	private ClassInfo clazz;
	private ExamPaperInfo examPaper;
	private String beginTime;

	public Integer getExamPlanId() {
		return examPlanId;
	}

	public void setExamPlanId(Integer examPlanId) {
		this.examPlanId = examPlanId;
	}

	public CourseInfo getCourse() {
		return course;
	}

	public void setCourse(CourseInfo course) {
		this.course = course;
	}

	public ClassInfo getClazz() {
		return clazz;
	}

	public void setClazz(ClassInfo clazz) {
		this.clazz = clazz;
	}

	public ExamPaperInfo getExamPaper() {
		return examPaper;
	}

	public void setExamPaper(ExamPaperInfo examPaper) {
		this.examPaper = examPaper;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	@Override
	public String toString() {
		return "ExamPlanInfo [examPlanId=" + examPlanId + ", course=" + course
				+ ", clazz=" + clazz + ", examPaper=" + examPaper
				+ ", beginTime=" + beginTime + "]";
	}

}
