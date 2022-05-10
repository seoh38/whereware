package com.ww.mvc.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ww.mvc.admin.model.dao.AdminMapper;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.document.model.dao.DocumentMapper;
import com.ww.mvc.document.model.vo.Document;

@Service
public class AdminServiceimlp implements AdminService {
	
	
	@Autowired
	private AdminMapper mapper;

	@Override
	public int getadminMemberSearchCount(Map<String, String> searchMap) {

		return mapper.getadminMemberSearchCount(searchMap);
	}

	@Override
	public List<Document> getadminMemberSearchList(Map<String, String> searchMap, PageInfo pageInfo) {
		 int offset = (pageInfo.getCurrentPage() - 1 ) * pageInfo.getListLimit();
		 int limit = pageInfo.getListLimit();
		 RowBounds rowBounds = new RowBounds(offset, limit);

		 return mapper.getadminMemberSearchList(rowBounds,searchMap);
	}

}
