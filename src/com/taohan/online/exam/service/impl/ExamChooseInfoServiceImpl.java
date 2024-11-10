package com.taohan.online.exam.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taohan.online.exam.dao.ExamChooseInfoMapper;
import com.taohan.online.exam.po.ExamChooseInfo;
import com.taohan.online.exam.service.ExamChooseInfoService;

/**
  *
  * <p>Title: ExamChooseInfoServiceImpl</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-25
  * @time: 上午10:35:03
  * @version: 1.0
  */

@Service
public class ExamChooseInfoServiceImpl implements ExamChooseInfoService {

	@Autowired
	private ExamChooseInfoMapper examChooseInfoMapper;

	//根据员工编号，试卷编号，试题编号获取选择记录
	public ExamChooseInfo getChooseWithIds(Map<String, Object> map) {
		return examChooseInfoMapper.getChooseWithIds(map);
	}

	//修改选择记录
	public int updateChooseWithIds(ExamChooseInfo examChoose) {
		return examChooseInfoMapper.updateChooseWithIds(examChoose);
	}

	//添加选择记录
	public int addChoose(Map<String, Object> map) {
		return examChooseInfoMapper.addChoose(map);
	}

	public List<ExamChooseInfo> getChooseInfoWithSumScore(
			Map<String, Object> map) {
		return examChooseInfoMapper.getChooseInfoWithSumScore(map);
	}

	public List<ExamChooseInfo> getChooseInfoWithExamSubject(
			Map<String, Object> map) {
		return examChooseInfoMapper.getChooseInfoWithExamSubject(map);
	}


}
