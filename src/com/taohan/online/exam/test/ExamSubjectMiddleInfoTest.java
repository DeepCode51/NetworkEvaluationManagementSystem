package com.taohan.online.exam.test;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

/**
  *
  * <p>Title: ExamSubjectMiddleInfoTest</p>
  * <p>Description: </p>
  * @author: taohan
  * @date: 2018-8-21
  * @time: 下午12:24:09
  * @version: 1.0
  */

public class ExamSubjectMiddleInfoTest {

	private SqlSessionFactory sqlSessionFactory;
	
	public void init() throws Exception {
		InputStream is = Resources.getResourceAsStream("test/SqlMapConfig-test.xml");
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
	}
	
	@Test
	public void addTest() throws Exception {
		init();
		
		SqlSession session = sqlSessionFactory.openSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("examPaperId", 2);
		ArrayList<Integer> subjectIds = new ArrayList<Integer>();
		subjectIds.add(100);
		subjectIds.add(200);
		subjectIds.add(300);
		subjectIds.add(400);
		map.put("subjectIds", subjectIds);
		
		session.insert("isAddESM", map);
		session.commit();
	}
}
