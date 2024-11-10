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

import com.taohan.online.exam.po.ClassInfo;
import com.taohan.online.exam.po.StudentInfo;
import com.taohan.online.exam.po.TeacherInfo;


/**
  *
  * <p>Title: TeacherInfoTest</p>
  * <p>Description: 员工测试</p>
  * @author: taohan
  * @date: 2018-8-17
  * @time: 上午8:41:35
  * @version: 1.0
  */

@SuppressWarnings("all")
public class StudentInfoTest {

	private SqlSessionFactory sqlSessionFactory;
	
	public void init() throws Exception {
		InputStream is = Resources.getResourceAsStream("test/SqlMapConfig-test.xml");
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
	}
	
	@Test
	public void test2() throws Exception {
		init();
		
		StudentInfo student = new StudentInfo();
		ClassInfo classInfo = new ClassInfo();
		classInfo.setClassId(1);
		student.setClassInfo(classInfo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("student", student);
		map.put("startIndex", 0);
		map.put("pageShow", 3);
		
		SqlSession session = sqlSessionFactory.openSession();
		List<StudentInfo> students = session.selectList("getStudents", map);
		System.out.println(students);

		session.close();
	}
}
