package test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
//import org.junit.Test;

import com.wt.bean.FunctionModule;
import com.wt.bean.user;

public class functionTest {
	
  public static void main(String[] args) {
	  String filepath="D:\\java\\tomcat\\apache-tomcat-6.0.53"+"\\bin\\"+"uploadDir1\\";
		System.out.println(filepath);
		 File file=new File(filepath);
		 if  (!file .exists()  && !file .isDirectory())      
		 {       
		     System.out.println("//������");  
		     file .mkdir();    
		 } else   
		 {  
		     System.out.println("//Ŀ¼����");  
		 }  
}
}