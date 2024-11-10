package com.taohan.online.exam.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.taohan.online.exam.po.ExamChooseInfo;
import com.taohan.online.exam.service.ExamChooseInfoService;

/**
  *
  * <p>Title: ExamChooseInfoHandler</p>
  * <p>Description: 试卷试题答案选择</p>
  * @author: taohan
  * @date: 2018-8-25
  * @time: 上午10:36:41
  * @version: 1.0
  */

@Controller
public class ExamChooseInfoHandler {
	
	@Autowired
	private ExamChooseInfoService examChooseInfoService;
	@Autowired
	private ExamChooseInfo examChoose;

	private Logger logger = Logger.getLogger(ExamChooseInfoHandler.class);
	
	/**
	 * 记录考生测评选择答案
	 * @param studentId 考生编号
	 * @param examPaperId 测评试卷编号
	 * @param subjectId 当前选择试题编号
	 * @param index 前台控制索引
	 * @param chooseAswer 选择答案
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/choose", method=RequestMethod.POST)
	public void examChooseHandler(
			@RequestParam("studentId") Integer studentId,
			@RequestParam("examPaperId") Integer examPaperId,
			@RequestParam("subjectId") Integer subjectId,
			@RequestParam(value="index", required=false) Integer index,
			@RequestParam("chooseAswer") String chooseAswer,
			HttpServletResponse response) throws IOException {
		logger.info("考生 "+studentId+" 在试卷 "+examPaperId+" 中试题 "+subjectId+" 选择了答案 "+chooseAswer+" 序号 "+index);
		
		//判断该考生是否已经选择过该试题
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studentId", studentId);
		map.put("examPaperId", examPaperId);
		map.put("subjectId", subjectId);
		examChoose = examChooseInfoService.getChooseWithIds(map);
		logger.info("考生是否选择过试题 "+subjectId+" "+examChoose+" (NULL-否)");
		if (examChoose == null) {
			logger.info("考生 "+studentId+" 尚未选择试题 "+subjectId+" 添加选择记录 答案 "+chooseAswer);
			map.put("chooseResult", chooseAswer);
			/** 添加选择记录 */
			examChooseInfoService.addChoose(map);
		} else if (examChoose.getChooseId() != null && examChoose != null) {
			logger.info("考生 "+studentId+" 已经选择试题 "+subjectId+" 修改选择记录 答案 "+examChoose.getChooseResult()+" 更新为 "+chooseAswer);
			/*
			 * 如果选择了和上次相同的答案，则不做修改操作
			 * 优化 -- 前台判断选择了相同答案则不发出请求
			 */
			if(!chooseAswer.equals(examChoose.getChooseResult())) {
				examChoose.setChooseResult(chooseAswer);
				/** 当前选择答案和之前选择答案不同 修改答案记录 */
				examChooseInfoService.updateChooseWithIds(examChoose);
			} else {
				logger.info("考生选择了相同答案，不做修改操作");
			}
		} else {
			response.getWriter().print("f");
			return;
		}
		
		response.getWriter().print("t");
	}
}
