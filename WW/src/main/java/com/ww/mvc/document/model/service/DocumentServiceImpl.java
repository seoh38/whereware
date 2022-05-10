package com.ww.mvc.document.model.service;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ww.mvc.board.model.vo.BoardAttach;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.document.controller.Document_Controller;
import com.ww.mvc.document.model.dao.DocumentMapper;
import com.ww.mvc.document.model.vo.Document;
import com.ww.mvc.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DocumentServiceImpl implements DocumentService {
	
	@Autowired
	private DocumentMapper mapper;
	
//	@Override
//	public int getDocumentCount() {
//		
//		return mapper.getDocumentCount();
//	}
//
//	@Override
//	public List<Document> getDocumentList(PageInfo pageInfo) {
//		
//		 int offset = (pageInfo.getCurrentPage() - 1 ) * pageInfo.getListLimit();
//		 int limit = pageInfo.getListLimit();
//		 RowBounds rowBounds = new RowBounds(offset, limit);
//
//		 return mapper.documentfindAll(rowBounds);
//	}


	@Override
	public List<Document> getDocumentSearchList(Map<String, String> searchMap, PageInfo pageInfo) {

		 int offset = (pageInfo.getCurrentPage() - 1 ) * pageInfo.getListLimit();
		 int limit = pageInfo.getListLimit();
		 RowBounds rowBounds = new RowBounds(offset, limit);

		 return mapper.getDocumentSearchList(rowBounds,searchMap);
	}

	@Override
	public int getDocumentSearchCount(Map<String, String> searchMap) {

		return  mapper.getDocumentSearchCount(searchMap);
	}
	
	
// 문서 정보
	@Override
	public Document getDocumentContent(int doc_no) {

		return mapper.getDocumentContent(doc_no);
	}
	
	
	// 문서 작성
	@Override
	@Transactional
	public int save(Document document) {
		int result = 0;
		
		if(document.getDoc_id()!= 0) {
			//update
			log.info(document.toString());
			result = mapper.InsertLinkDocument(document);
			mapper.InsertAttachDocument(document);
			
		} else {
			// insert
			result = mapper.getInsertDocument(document);
			log.info(document.toString());
			
			mapper.InsertLinkDocument(document);
			mapper.InsertAttachDocument(document);


		}
		
		return result;
	}
	
	//회원 정보 불러오기
	@Override
	public List<Member> getMemberMinList() {

		return mapper.getMemberMinList();
	}

	@Override
	@Transactional
	public int delete(int doc_id, String link_type, int link_num) {
		
		if( link_type.equals("S4")) {
			mapper.documentStatus(doc_id,"N");
		} 

		return mapper.documentLink(link_num,link_type);
	}





	
	
	
}
