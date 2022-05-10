package com.ww.mvc.document.model.service;

import java.util.List;
import java.util.Map;

import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.document.model.vo.Document;
import com.ww.mvc.member.model.vo.Member;

public interface DocumentService {

//	int getDocumentCount();
//
//	List<Document> getDocumentList(PageInfo pageInfo);

	int getDocumentSearchCount(Map<String, String> searchMap);

	List<Document> getDocumentSearchList(Map<String, String> searchMap, PageInfo pageInfo);

	Document getDocumentContent(int doc_no);

	int save(Document document);

	List<Member> getMemberMinList();

	int delete(int doc_id, String link_type, int link_num);

	
	
}
