package com.wt.serviceimp;

import java.io.InputStream;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wt.basedao.*;
import com.wt.bean.News;
@Service("newsService")
public class NewsService {
	 String resource="cfg.xml";
	 InputStream is = FunctionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 newsDao newsDao=session.getMapper(newsDao.class);
	public List<News>getNewsList(){
		return newsDao.getNewsList();
	}
	public List<News>getNewsListByDate(String startDate,String endDate,String newstitle){
		return newsDao.getNewsListByDate(startDate, endDate,newstitle);
	}
	public News getNewsById(long id){
		return newsDao.getNewsById(id);
	}@Transactional
	public String updateNews(News news,long id,String newsTitle,String nowDate,String newsContent){
		newsDao.updateNews(news, id, newsTitle, nowDate, newsContent);
		session.commit();
		return null;
}   @Transactional
	public String  insertNews(News news){
	newsDao.insertNews(news);
	session.commit();
		return null;
	}
public List<News> getNewsListByCriteria(int startPos,int endPos){
	return newsDao.getNewsListByCriteria(startPos, endPos);
}
public List<News> getSomeNewsListByCriteria(String startDate,String endDate,String newstitle,int startPos,int endPos){
	return newsDao.getSomeNewsListByCriteria(startDate, endDate,newstitle, startPos, endPos);
}
public List<News> getNewsListByMaxDate(){
	return newsDao.getNewsListByMaxDate();
}
public News getNewestNews(){
	return newsDao.getNewestNews();
}
public String deleteNewsById(long newsId){
	newsDao.deleteNewsById(newsId);
	session.commit();
	return null;
}
}