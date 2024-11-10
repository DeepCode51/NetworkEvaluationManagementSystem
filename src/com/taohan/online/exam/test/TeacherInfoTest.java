package com.taohan.online.exam.test;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.taohan.online.exam.po.TeacherInfo;


/**
  *
  * <p>Title: TeacherInfoTest</p>
  * <p>Description: HR测试</p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 上午8:41:35
  * @version: 1.0
  */

@SuppressWarnings("all")
public class TeacherInfoTest {

	private SqlSessionFactory sqlSessionFactory;
	
	public void init() throws Exception {
		InputStream is = Resources.getResourceAsStream("test/SqlMapConfig-test.xml");
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
	}
	
	//分页测试
	@Test
	public void paginationTest() throws Exception {
		init();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startPage", 0);
		map.put("pageShow", 2);
		
		SqlSession session = sqlSessionFactory.openSession();
		List<TeacherInfo> teachers = session.selectList("getTest", map);
		System.out.println(teachers);

		session.close();
	}
	
	@Test
	public void test2() throws Exception {
		init();
		
		TeacherInfo teacherInfo = new TeacherInfo();
		teacherInfo.setIsWork(1);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("teacher", teacherInfo);
		map.put("startIndex", 1);
		map.put("pageShow", 3);
		
		SqlSession session = sqlSessionFactory.openSession();
		List<TeacherInfo> teachers = session.selectList("getTeachers", map);
		System.out.println(teachers);

		session.close();
	}
}
