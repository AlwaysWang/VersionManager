package page;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Date1 {
	public static void main(String[] args) {
		Date date= new Date();//����һ��ʱ����󣬻�ȡ����ǰ��ʱ��
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//����ʱ����ʾ��ʽ
		String str = sdf.format(date);//����ǰʱ���ʽ��Ϊ��Ҫ������
		System.out.println(str);//������
		
	}
	
}
