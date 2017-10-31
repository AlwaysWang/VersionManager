package fileoperateutil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import page.HttpUtils;

public class download {
	private static DownloadRecord downloadRecord;
	public static DownloadRecord getDownloadRecord() {
		return downloadRecord;
	}
	public static void setDownloadRecord(DownloadRecord downloadRecord) {
		download.downloadRecord = downloadRecord;
	}
	public static void download(String fileName, String filePath,
			HttpServletRequest request, HttpServletResponse response) 
			throws Exception,FileNotFoundException {
			    //������������״̬�ļ�¼����
			   downloadRecord = new DownloadRecord(fileName, filePath, request);
			    //������Ӧͷ�Ϳͻ��˱����ļ���
			   // response.setCharacterEncoding("utf-8");
			  //  response.setContentType("multipart/form-data");
			  //  response.setHeader("Content-Disposition", "attachment;fileName=" + new String(fileName.getBytes("utf-8"), "ISO8859_1"));
			   response.setContentType("application/octet-stream");    
			   boolean isMSIE = HttpUtils.isMSBrowser(request);    
			   if (isMSIE) {    
			 //IE浏览器的乱码问题解决  
			        fileName = URLEncoder.encode(fileName, "UTF-8");    
			   } else {    
			 //万能乱码问题解决  
			        fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");    
			   }    
			   response.setHeader("Content-disposition", "attachment;filename=\"" + fileName + "\"");    
			   //剩下的就是将文件流输出到response    
			// eCopyUtils.copy(inputStream, response.getOutputStream); 
			   long downloadedLength = 0l;
			   long length1=new File(filePath).length();
			   System.out.println(length1+"length1");
                    File dir = new File(filePath);
              if(dir.exists()){
			        InputStream inputStream = new FileInputStream(filePath);
			        //�������ز���
			        OutputStream os = response.getOutputStream();
			        byte[] b = new byte[2048];
			        int length;
			        while ((length = inputStream.read(b)) > 0) {
			            os.write(b, 0, length);
			            downloadedLength += b.length;
			        }

			        // ������Ҫ�رա�
			       
			        os.close();
			        inputStream.close();
              }
              else{
            	  System.out.println("�ļ�������");
              }
			    
			    /*catch (Exception e){
			        downloadRecord.setStatus(DownloadRecord.STATUS_ERROR);
			        throw e;
			    }*/
			    //downloadRecord.setStatus(DownloadRecord.STATUS_SUCCESS);
			    //downloadRecord.setEndTime(new Timestamp(System.currentTimeMillis()));
			   // downloadRecord.setLength(downloadedLength);
			    //�洢��¼

			    }
			  
			
	public static void main(String[] args) throws Exception {
		download d=new download();
		//HttpServletRequest request = null;
		//HttpServletResponse response = null;
		//d.download("����", " D:\\javatomcat\\apache-tomcat-6.0.53\\webapps\\wt\\uploadDir\\chengxuxiugai.txt", request, response);
		InputStream inputStream = new FileInputStream("D:\\java\\tomcat\\apache-tomcat-6.0.53\\webapps\\wt\\uploadDir\\����1.txt ");
		//InputStream inputStream=new FileInputStream("D:/java/tomcat/apache-tomcat-6.0.53/webapps/wt/�����޸�.docx");
		System.out.println(inputStream);
	}
}
