package com.ww.mvc.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ww.mvc.member.model.dao.MemberMapper;
import com.ww.mvc.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public Member findMemberByNo(int no) {
		
		return mapper.findMemberByNo(no);
	}
	
	@Override
	public Member findMemberById(String id) {
	
		return mapper.findMemberById(id);
	}
	
	// 로그인
	@Override
	public Member login(String id, String password) {
		Member member = null;
		
		member = this.findMemberById(id);
		
		return member != null && 
				passwordEncoder.matches(password, member.getPassword()) ? member : null;
	}
	
	@Override
	public String findId(Member member) {
		
		return mapper.findId(member);
	}
	
	// 회원가입 및 업데이트
	@Override
	@Transactional
	public int save(Member member) {
		int result = 0;
		
		if(member.getNo() != 0) {
			// update
			result =  mapper.updateMember(member);
		} else {
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			result = mapper.insertMember(member);
		}
		return result;
	}

	@Override
	@Transactional
	public int deleteMember(int no) {
		
		return mapper.deleteMember(no);
	}
	
	@Override
	public Boolean isDuplicateID(String userId) {
		
		return this.findMemberById(userId) != null;
	}


	@Override
	@Transactional
	public int updatePwd(Member member) {
		int result = 0;
		
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		
		result = mapper.updatePwd(member);
		
		return result;
	}


}
