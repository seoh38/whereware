package com.ww.mvc.admin.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ww.mvc.admin.model.service.AdminService;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.document.model.vo.Document;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service ;
	

	// ▼  리스트
	@GetMapping("/member/list")
	public ModelAndView documentList(ModelAndView model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int pages,
			@RequestParam(defaultValue = "name") String type,
			@RequestParam(defaultValue = "") String search	
			) {
		
		Map<String, String> searchMap = new HashMap<String, String>();
		
		searchMap.put("type", type);
		searchMap.put("search", search);
		
		int adminMemberSearchCount = service.getadminMemberSearchCount(searchMap);
		PageInfo pageInfo = new PageInfo(page, 10, adminMemberSearchCount, pages);
		List<Document> adminMemberSearchList = service.getadminMemberSearchList(searchMap,pageInfo);
		
		model.addObject("searchMap", searchMap);
		model.addObject("pageInfo", pageInfo);
		model.addObject("memberList",adminMemberSearchList);
		model.setViewName("admin/memberList");
		
		return model;

	}
	
	
	
}
