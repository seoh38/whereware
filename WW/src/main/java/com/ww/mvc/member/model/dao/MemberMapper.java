package com.ww.mvc.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ww.mvc.member.model.vo.Member;

@Mapper
@Repository
public interface MemberMapper {
	
	Member selectMember(@Param("id") String id);
	
	// 회원가입
	int insertMember(Member member);

	// 아이디 찾기
	Member findMemberById(@Param("id") String id);

	// 회원정보 수정
	int updateMember(Member member);
	
	// 아이디 검색해서 찾기
	String findId(Member member);

	// 회원 정보 삭제
	int deleteMember(int no);
	
	// 비밀번호 변경
	int updatePwd(Member member);

	Member findMemberByNo(int no);

	void searchPassword(@Param("id") String id, @Param("email") String email, @Param("key") String key);

}
