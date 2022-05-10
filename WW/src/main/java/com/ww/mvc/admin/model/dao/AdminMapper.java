package com.ww.mvc.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.ww.mvc.document.model.vo.Document;

@Mapper
public interface AdminMapper {

	int getadminMemberSearchCount(Map<String, String> searchMap);

	List<Document> getadminMemberSearchList(RowBounds rowBounds, Map<String, String> searchMap);

}
