package com.wt.basedao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wt.bean.News;
@Repository
public interface newsDao {
public List<News> getNewsList();
public List<News> getNewsListByDate(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("newstitle")String newstitle);
public News getNewsById(@Param("id")long id);
public int updateNews(News news,@Param("id")long id,@Param("newsTitle")String newsTitle,@Param("nowDate")String nowDate,@Param("newsContent")String newsContent);
public int insertNews(News news);
public List<News> getNewsListByCriteria(@Param("StartPos")int startPos,@Param("EndPos")int endPos);
public List<News> getSomeNewsListByCriteria(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("newstitle")String newstitle,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
public List<News> getNewsListByMaxDate();
public News getNewestNews();
public int deleteNewsById(long newsId);
}