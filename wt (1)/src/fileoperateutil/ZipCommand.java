package fileoperateutil;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.*;
import java.io.*;
public class ZipCommand {
     private static int ziplevel = 7;
     private File sourceFile = null;
     private File  zipFile = null;
     private ZipOutputStream jos = null;
     private ZipEntry sourEntry = null;
     private String zipfileName = null;
     private String sourceFileName = null;
     private static byte[] buf = new byte[1024];
      
     public static void main(String[] s){
         ZipCommand tz = new ZipCommand();
         List sourcefilelist=new ArrayList();
         sourcefilelist.add("D:/CloudMusic/resource");
         sourcefilelist.add("D:/CloudMusic/skin");
         
        System.out.println( tz.AddtoZip(sourcefilelist));
     }
      
    public String AddtoZip(List sourcefilelist){
        if(sourcefilelist == null || sourcefilelist.size()<1){
            return null;
        }
        sourceFile = new File(sourcefilelist.get(0).toString());
        if(!sourceFile.isFile()){
            return null;
        }else{
            sourceFileName = sourceFile.getName();
            this.setZipfileName(sourceFileName.substring(0,sourceFileName.lastIndexOf("."))+".zip");
            try{
            zipFile = new File(sourceFile.getParent(),this.getZipfileName());
 
            if(zipFile.exists()){
                int i = 1 ;
                while(true){
                    zipFile = new File(sourceFile.getParent(),this.getZipfileName().substring(0, getZipfileName().lastIndexOf(".zip")) + i + ".zip");
                    if(!zipFile.exists()) break ;
                    i++ ;
                }
            }
            //System.out.println(zipFile.getPath());
             if(zipFile.exists()){
                 zipFile.deleteOnExit();
             }
             zipFile.createNewFile();
             jos = new ZipOutputStream(new FileOutputStream(zipFile));
             jos.setLevel(ziplevel);
             for(int i=0;i<sourcefilelist.size();i++){
             
             Stzip(jos,new File(sourcefilelist.get(i).toString()));
             }
             jos.finish();
            }catch(Exception e){
                return null;
            }
            if(zipFile !=null)
            return zipFile.getPath();
            else{
                return null;
            }
        }
    }
     
     private  void Stzip(ZipOutputStream jos, File file)
     throws IOException, FileNotFoundException
 {
          
         sourEntry= new ZipEntry(file.getName());
         FileInputStream fin = new FileInputStream(file);
         BufferedInputStream in = new BufferedInputStream(fin);
         jos.putNextEntry(sourEntry);
         int len;
         while ((len = in.read(buf)) >= 0) 
             jos.write(buf, 0, len);
         in.close();
         jos.closeEntry();
          
      
 }
 
      
    public File getSourceFile() {
        return sourceFile;
    }
    public void setSourceFile(File sourceFile) {
        this.sourceFile = sourceFile;
    }
 
    public String getZipfileName() {
        return zipfileName;
    }
 
    public void setZipfileName(String zipfileName) {
        this.zipfileName = zipfileName;
    }
     
}
