package com.ww.mvc.document.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.ww.mvc.document.model.vo.Document;
import com.ww.mvc.member.model.vo.Member;

@Mapper
public interface DocumentMapper {

//	int getDocumentCount();
//
//	List<Document> documentfindAll(RowBounds rowBounds);

	int getDocumentSearchCount(Map<String, String> searchMap);

	List<Document> getDocumentSearchList(RowBounds rowBounds, Map<String, String> searchMap);

	Document getDocumentContent(int doc_no);

	int UpdateDocument(Document document);

	int getInsertDocument(Document document);
	
	int InsertLinkDocument(Document document);

	void InsertAttachDocument(Document document);
	
	List<Member> getMemberMinList();
	
	int documentLink(@Param("link_num") int link_num, @Param("link_type") String link_type);

	void documentStatus(@Param("doc_id")int doc_id, @Param("doc_status") String doc_status);




	
// 아직 안씀
	Document getLoginMemberInfo(int no);










}
