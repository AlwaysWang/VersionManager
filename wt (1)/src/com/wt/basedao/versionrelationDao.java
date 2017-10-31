package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.VersionRelation;

@Repository
public interface versionrelationDao {
	public int insertVersionRelation(VersionRelation versionrelation);
	public List<VersionRelation> getversionrelationByVId(@Param("vId")long vId);
	public int deleteVersionRelationByVId(@Param("vId")long vId);
	public int deleteVersionRelationByFunId(long funId);
	public List<VersionRelation> getversionrelationByFId(long FunId);
}
