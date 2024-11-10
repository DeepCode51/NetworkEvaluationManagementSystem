package com.taohan.online.exam.util;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.taohan.online.exam.po.CourseInfo;
import com.taohan.online.exam.po.GradeInfo;
import com.taohan.online.exam.po.SubjectInfo;

/**
  *
  * <p>Title: SubjectImportUtil</p>
  * <p>Description: 试题文件导入工具类</p>
  * @author: taohan
  * @date: 2018-9-6
  * @time: 下午2:42:11
  * @version: 1.0
  */

@SuppressWarnings("all")
public class SubjectImportUtil {
	private static int subjectNameIndex;
	private static int optionAIndex;
	private static int optionBIndex;
	private static int optionCIndex;
	private static int optionDIndex;
	private static int rightResultIndex;
	private static int subjectScoreIndex;
	private static int subjectTypeIndex;
	private static int subjectEasyIndex;

	/**
	 * 解析导入 excel 生成试题对象
	 * @param filePath
	 * @param indexs
	 * @param courseId
	 * @param gradeId
	 * @param division
	 * @return
	 */
	public static List<SubjectInfo> parseSubjectExcel(String filePath, Integer courseId, Integer gradeId, Integer division) {
		List<SubjectInfo> subjects = new LinkedList<SubjectInfo>();
		try {
			//读取工作本
			XSSFWorkbook workBook = new XSSFWorkbook(filePath);
			//读取工作簿
			XSSFSheet sheet = workBook.getSheet("Sheet1");
			//总行数
			int sumRow = sheet.getLastRowNum()-sheet.getFirstRowNum();
			
			//第一行
			XSSFRow firstRow = sheet.getRow(0);
			getCellIndexs(firstRow);
			
			for (int i = 1; i <= sumRow; i++) {
				XSSFRow row = (XSSFRow) sheet.getRow(i);
				XSSFCell subjectName = row.getCell(subjectNameIndex);
				XSSFCell optionA = row.getCell(optionAIndex);
				XSSFCell optionB = row.getCell(optionBIndex);
				XSSFCell optionC = row.getCell(optionCIndex);
				XSSFCell optionD = row.getCell(optionDIndex);
				XSSFCell rightResult = row.getCell(rightResultIndex);
				XSSFCell subjectScore = row.getCell(subjectScoreIndex);
				if(subjectScore.getCellType()==0) { subjectScore.setCellType(1); }
				XSSFCell subjectType = row.getCell(subjectTypeIndex);
				XSSFCell subjectEasy = row.getCell(subjectEasyIndex);
				
				SubjectInfo subject = new SubjectInfo();
				subject.setSubjectName(subjectName.toString());
				
				subject.setOptionA(optionA == null ? "" : optionA.toString());
				subject.setOptionB(optionB == null ? "" : optionB.toString());
				subject.setOptionC(optionC == null ? "" : optionC.toString());
				subject.setOptionD(optionD == null ? "" : optionD.toString());
				
				subject.setRightResult(rightResult.toString());
				subject.setSubjectScore(Integer.parseInt(subjectScore.toString()));
				//试题类型
				if("单选".equals(row.getCell(subjectTypeIndex).toString())){
					subject.setSubjectType(0);
				}else if("多选".equals(row.getCell(subjectTypeIndex).toString())){
					subject.setSubjectType(1);
				}else{
					subject.setSubjectType(2);
				}
				
				if ("简单".equals(subjectEasy.toString())) {
					subject.setSubjectEasy(0);					
				} else if ("普通".equals(subjectEasy.toString())) {
					subject.setSubjectEasy(1);					
				} else {
					subject.setSubjectEasy(2);						
				}
				subject.setCourse(new CourseInfo(courseId));
				subject.setGrade(new GradeInfo(gradeId));
				subject.setDivision(division);
				
				subjects.add(subject);
			}
			
			workBook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return subjects;
	}
	
	
	/**
	 * 解析第一行标题名得到列索引
	 * @param firstRow
	 */
	private static void getCellIndexs(XSSFRow firstRow) {
		int cellNum = firstRow.getLastCellNum()-firstRow.getFirstCellNum();
		for (int i=0; i<cellNum; i++) {
			String cell = firstRow.getCell(i).toString();
			if ("题目".equals(cell)) {
				subjectNameIndex = i;
				continue;
			}
			if ("答案A".equals(cell)) {
				optionAIndex = i;
				continue;
			}
			if ("答案B".equals(cell)) {
				optionBIndex = i;
				continue;
			}
			if ("答案C".equals(cell)) {
				optionCIndex = i;
				continue;
			}
			if ("答案D".equals(cell)) {
				optionDIndex = i;
				continue;
			}
			if ("正确答案".equals(cell)) {
				rightResultIndex = i;
				continue;
			}
			if ("分值".equals(cell)) {
				subjectScoreIndex = i;
				continue;
			}
			if ("试题类型".equals(cell)) {
				subjectTypeIndex = i;
				continue;
			}
			if ("难易程度".equals(cell)) {
				subjectEasyIndex = i;
				continue;
			}
		}
	}
}
