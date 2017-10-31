package page;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.formula.functions.T;
public class ExcelUtils<T extends Object> {

	public ExcelUtils() {
	}

	public void exportExceptionExcel(HttpServletResponse response,HttpServletRequest request,
	//public void exportExceptionExcel(File file,
			String[] title, List<T> beanList,String fileName)
			throws FileNotFoundException {
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		// 设置行宽
		sheet.setDefaultColumnWidth((short) 10);
		// 生成一个样式
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 居中

		// 创建表头标题
		HSSFRow row0 = sheet.createRow(0);
		for (int i = 0; i < title.length; i++) {
			HSSFCell cell = row0.createCell((short) i);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);
			// HSSFRichTextString textString = new
			// HSSFRichTextString(title[i]);
			// 建议使用富文本格式 为方便起 直接使用string
			String head = null;
			if (title[i].equals("verCode")) {
				head = "版本号";
			}
			else if (title[i].equals("verName")) {
				head = "版本名称";
			}else if (title[i].equals("remark")) {
				head = "点击查看版本描述";
			}else if (title[i].equals("istDateFormat")) {
				head = "创建日期";
				sheet.setDefaultColumnWidth((short) 20);
			}else if (title[i].equals("pgdownload")) {
				head = "程序下载";
			}
		/*	else if (title[i].equals("edit")) {
				head = "修改";
			}
			else if (title[i].equals("delete")) {
				head = "删除";
			}*/
			else if (title[i].equals("pgEdition")) {
				head = "程序版本信息";
			}
			else if (title[i].equals("debugFile")) {
				head = "调试手册下载";
			}
			else if (title[i].equals("typeName")) {
				head = "测试类别";
			}
			else if (title[i].equals("name")) {
				head = "功能名称";
			}
			else if (title[i].equals("id")) {
				head = "功能ID";
			}
				
			cell.setCellValue(head);
		}
		// 创建数据
		int index = 1;
		HSSFRow row = null;
		for (Iterator<T> iterator = beanList.iterator(); iterator.hasNext(); index++) {

			row = sheet.createRow(index);
			sheet.getRow(index).getCell((short)2).setEncoding(HSSFCell.ENCODING_UTF_16);
			T t = (T) iterator.next();
			Class<? extends Object> clazz = t.getClass();
			// 通过反射获取包括私有的全部属性
			// Field[] fields = t.getClass().getDeclaredFields();
			for (int i = 0; i < title.length; i++) {
				// 根据表头来创建单元格
				HSSFCell cell = row.createCell((short) i);
				//cell.setEncoding("utf-8");
				String fieldName = title[i];
				String methodName = "get"
						+ fieldName.substring(0, 1).toUpperCase()
						+ fieldName.substring(1);
				String textValue = null;
				try {
					Method method = clazz.getMethod(methodName, new Class[] {});
					Object value = method.invoke(t, new Object[] {});
					if (value instanceof Double) {
						textValue = NumberFormat.getPercentInstance().format(
								value);
					} else if (null == value || "" == value) {
						textValue = null;
					} else {
						textValue = value.toString();
					}
					cell.setCellValue(textValue);
          if(title[i].equals("remark")){
        	  cell.setCellValue("版本描述");
          }
      /*    if(title[i].equals("delete")){
        	  cell.setCellValue("删除");
          }
          if(title[i].equals("edit")){
        	  cell.setCellValue("修改");
          }*/
          if(title[i].equals("pgdownload")){
        	  cell.setCellValue("对应程序下载");
          }
          if(title[i].equals("debugFile")){
        	  cell.setCellValue("调试手册下载");
          }
          if(title[i].equals("pgEdition")){
        	  cell.setCellValue("程序版本信息");
          }
				} catch (Exception e) {
					System.out.println("反射出错");
					// throw new Exception("反射出错");
					e.printStackTrace();
				}
			}
		}
		OutputStream os = null; 
		try{
			//response.setHeader("Content-disposition", "attachment;filename=\"" + "版本列表.xlsxdfdff" + "\"");  
			os = response.getOutputStream();
			response.setHeader("Content-disposition", "attachment;filename=\"" + fileName + "\"");  
			wb.write(os);
			System.out.println("导出成功");
		} catch (Exception e) {
			System.out.println("写出失败");
			e.printStackTrace();
		} finally {
			if (os != null) {
				try {
					os.flush();
					os.close();
				} catch (IOException e) {
					System.out.println("输出流关闭失败");
					e.printStackTrace();
				}
			}
		}
	}
}