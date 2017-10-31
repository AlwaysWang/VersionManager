package fileoperateutil;

import java.io.BufferedInputStream;  
import java.io.BufferedOutputStream;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
import java.io.InputStream;
import java.text.SimpleDateFormat;  
import java.util.ArrayList;  
import java.util.Date;  
import java.util.HashMap;  
import java.util.Iterator;  
import java.util.List;  
import java.util.Map;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import org.apache.tools.zip.ZipEntry;  
import org.apache.tools.zip.ZipOutputStream;  
import org.springframework.util.FileCopyUtils;  
import org.springframework.web.multipart.MultipartFile;  
import org.springframework.web.multipart.MultipartHttpServletRequest; 
public class FileOperateUtil {  
    private static final String REALNAME = "realName";  
    private static final String STORENAME = "storeName";  
    private static final String SIZE = "size";  
    private static final String SUFFIX = "suffix";  
    private static final String CONTENTTYPE = "contentType";  
    private static final String CREATETIME = "createTime";  
    public static final String UPLOADDIR = "uploadDir/";  
  
    /** 
     *  
     * @author geloin 
     * @date 2012-3-29 下午3:39:53 
     * @param name 
     * @return 
     */  
    private static String rename(String name){
        Long now = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmss")  
                .format(new Date()));  
        Long random = (long) (Math.random() * now);  
        String fileName = now + "" + random;  
        if (name.indexOf(".") != -1) {  
            fileName += name.substring(name.lastIndexOf("."));  
        }  
  
        return fileName;  
    }  
  
    /** 
     * 压缩后的文件名 
     *  
     * @author geloin 
     * @date 2012-3-29 下午6:21:32 
     * @param name 
     * @return 
     */  
    private static String zipName(String name) {  
        String prefix = "";  
        if (name.indexOf(".") != -1) {  
            prefix = name.substring(0, name.lastIndexOf("."));  
        } else {  
            prefix = name;  
        }  
        return prefix + ".zip";  
    }  
  
    /** 
     * 上传文件 
     *  
     * @author geloin 
     * @date 2012-5-5 下午12:25:47 
     * @param request 
     * @param params `
     * @param values 
     * @return 
     * @throws Exception 
     */  
    public static List<Map<String, Object>> upload(MultipartFile  mFile,String  uploadDir, 
            String[] params, Map<String, Object[]> values) throws Exception {  
        File file = new File(uploadDir);  
        if (!file.exists()) {  
            file.mkdir();  
        }  
        String fileName = null;  
        int i = 0;  
            fileName = mFile.getOriginalFilename();  
            //String storeName = rename(fileName);  
            String storeName=mFile.getOriginalFilename();
            String noZipName = uploadDir + storeName;  
            //String zipName = zipName(noZipName);  
  
            // 上传成为压缩文件  
            int len=0;
            InputStream in = mFile.getInputStream(); 
            byte[] buffer = new byte[1024];  
            ZipOutputStream outputStream = new ZipOutputStream(  
                    new BufferedOutputStream(new FileOutputStream(noZipName)));  
           // outputStream.putNextEntry(new ZipEntry(fileName));  
            outputStream.setEncoding("utf-8");  
            while ((len = in.read(buffer)) != -1) {  
            	outputStream.write(buffer, 0, len);  
            }  

            outputStream.close();  
            in.close();  
  
            FileCopyUtils.copy(mFile.getInputStream(), outputStream);  
  
            Map<String, Object> map = new HashMap<String, Object>();  
            // 固定参数值对  
            map.put(FileOperateUtil.REALNAME, zipName(fileName));  
            map.put(FileOperateUtil.STORENAME, zipName(storeName));  
            map.put(FileOperateUtil.SIZE, new File(noZipName).length());  
            //map.put(FileOperateUtil.SUFFIX, "zip");  
            map.put(FileOperateUtil.CONTENTTYPE, "application/octet-stream");  
            //map.put(FileOperateUtil.CREATETIME, new Date());  
        return null;  
    }  
   
    /** 
     * 下载 
     *  
     * @author geloin 
     * @date 2012-5-5 下午12:25:39 
     * @param request 
     * @param response 
     * @param storeName 
     * @param contentType 
     * @param realName 
     * @throws Exception 
     */  
    public static void download(HttpServletRequest request,  
            HttpServletResponse response, String storeName, String contentType,  
            String realName) throws Exception {  
        response.setContentType("text/html;charset=UTF-8");  
        request.setCharacterEncoding("UTF-8");  
        BufferedInputStream bis = null;  
        BufferedOutputStream bos = null;  
        String ctxPath = request.getSession().getServletContext()  
                .getRealPath("/")  
                + FileOperateUtil.UPLOADDIR;  
        //String downLoadPath = ctxPath + storeName;  
        String downLoadPath = storeName;  
        System.out.println(downLoadPath+"downLoadPath");
        System.out.println(downLoadPath.length());
        System.out.println(new File(downLoadPath).length()+"hello");
      if(new File(downLoadPath).length()>0){ 
    	 
    	 long fileLength = new File(downLoadPath).length(); 
        response.setContentType(contentType);  
        response.setHeader("Content-disposition", "attachment; filename="  
                + new String(realName.getBytes("utf-8"), "ISO8859_1"));  
        response.setHeader("Content-Length", String.valueOf(fileLength)); 
        bis = new BufferedInputStream(new FileInputStream(downLoadPath));
        System.out.println("bis"+bis);
        bos = new BufferedOutputStream(response.getOutputStream());  
        byte[] buff = new byte[2048];  
        int bytesRead;  
        if(bis!=null){
        	while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
            bos.write(buff, 0, bytesRead);  
        }  
        bis.close();  
        bos.close(); 
        }
        else{
        	System.out.println("出错");
        }
        }
      else{
    	  System.out.println("出错");
      }
      
    }  
    }

