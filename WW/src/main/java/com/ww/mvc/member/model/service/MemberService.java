package com.ww.mvc.member.model.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ww.mvc.member.model.vo.Member;

@Component
public interface MemberService {
	
	Member findMemberById(String id);
	
	int save(Member member);

	Member login(String id, String password);

	Boolean isDuplicateID(String userId);

	String findId(Member member);

	int deleteMember(int no);

	int updatePwd(Member member);
	
	Member findMemberByNo(int no);

}
