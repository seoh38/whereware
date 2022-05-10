package com.ww.mvc.admin.model.service;

import java.util.List;
import java.util.Map;

import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.document.model.vo.Document;

public interface AdminService {

	int getadminMemberSearchCount(Map<String, String> searchMap);

	List<Document> getadminMemberSearchList(Map<String, String> searchMap, PageInfo pageInfo);

}
