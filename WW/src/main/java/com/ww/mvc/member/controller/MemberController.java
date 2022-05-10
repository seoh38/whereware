package com.ww.mvc.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ww.mvc.member.model.vo.Member;
import com.ww.mvc.member.model.service.UserMailSendService;
import com.ww.mvc.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes("loginMember") // session 범위까지 확장!
public class MemberController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService service;
	
	// 로그인 페이지 이동
	@GetMapping("/login")
	public String login() {
		
		log.info("로그인 페이지 요청");
		
		return "member/login";
	};
	
	// 로그인 처리
	@RequestMapping(value="/login", method = {RequestMethod.POST})
	public ModelAndView login(
			ModelAndView model,
			@RequestParam("id") String id, @RequestParam("password") String password) {
		
		log.info("{}, {}", id, password);
		
		Member loginMember = service.login(id, password);
		
		if (loginMember != null) {
			// 로그인 성공
			model.addObject("msg", "로그인에 성공하셨습니다.");
			
			model.addObject("loginMember", loginMember);			
	         model.addObject("location", "/cmt/dashboard");
	         model.setViewName("common/msg");

			log.info("{}, {}", id, password);
			log.info(loginMember.toString());
		} else {
			// 로그인 실패
			model.addObject("msg", "아이디나 비밀번호가 일치하지 않습니다.");
			
			model.addObject("location", "/member/login");
			model.setViewName("common/msg");
		}
			
		return model;
	}
	
	// 이용약관 페이지 열기!
	@GetMapping("/joinTerms")
	public String joinTerms() {
		
		return "member/joinTerms";
	}
	
	// 로그아웃 처리
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		
		status.setComplete();
		
		log.info("로그아웃 성공 : {}", status.isComplete());
		
		return "member/login"; 
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/enroll")
	public String enroll() {
		
		log.info("회원 가입 페이지 요청");
		
		return "member/enroll";
	}
	
	// 회원가입
	@PostMapping("/enroll")
	public ModelAndView enroll(
			ModelAndView model, 
			@ModelAttribute Member member,
			HttpServletRequest request,
			@RequestParam("upload_profile") MultipartFile upload_profile) {
		
		// 로그 찍어보기!
		log.info(member.toString());
		
		// 파일을 업로드하지 않으면 "", 파일을 업로드하면 "파일명"
		log.info("Upfile Name : {}", upload_profile.getOriginalFilename());
		// 파일을 업로드하지 않으면 true, 파일을 업로드하면 false 
		log.info("Upfile is Empty : {}", upload_profile.isEmpty());
		
		if (upload_profile != null && !upload_profile.isEmpty()) {
			String renameFileName = saveFile(upload_profile, request);
			
			System.out.println(renameFileName);
			
			if (renameFileName != null) {
				member.setOriginalProfilename(upload_profile.getOriginalFilename());
				member.setRenamedProfilename(renameFileName);
				
				log.info("original : {} " + member.getOriginalProfilename());
				log.info("renamed : {} " + member.getRenamedProfilename());
			}
		}
		
		int result = service.save(member); // 정수값 리턴
		
		if (result > 0) {
			model.addObject("msg", "회원가입이 정상적으로 완료되었습니다.");
			model.addObject("location", "/member/login");
		} else {
			model.addObject("msg", "회원가입을 실패하였습니다.");
			model.addObject("location", "/member/enroll");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	// 마이페이지 이동
	@GetMapping("/mypageModify")
	public String myPage() {
		
		log.info("회원 수정 페이지 요청");
		
		return "member/mypageModify";
	}
	
	// 마이페이지 업데이트
	@PostMapping("/mypageModify")
	public ModelAndView mypageModify(
			ModelAndView model,
			@SessionAttribute(name = "loginMember") Member loginMember,
			@ModelAttribute Member member,
			@RequestParam("upload_profile") MultipartFile reloadImgFile,
			HttpServletRequest request) {
		int result = 0;
		
		// 로그인멤버 아이디와 멤버 아이디가 같으면...!
		if (loginMember.getId().equals(member.getId())) {
			member.setNo(loginMember.getNo());
			
			if (reloadImgFile != null && !reloadImgFile.isEmpty()) {
				if (member.getRenamedProfilename() != null) {
					deleteImg(member.getRenamedProfilename(), request);
				}
				
				String renamedFile = saveFile(reloadImgFile, request);
				
				if (renamedFile != null) {
					member.setOriginalProfilename(reloadImgFile.getOriginalFilename());
					member.setRenamedProfilename(renamedFile);
				}
			}
		}
		
		result = service.save(member);
		
		if(result > 0) {
			model.addObject("loginMember", service.findMemberById(loginMember.getId()));
			model.addObject("msg", "회원정보 수정을 완료했습니다.");
			model.addObject("location", "/member/mypageModify");
		} else {
			model.addObject("msg", "회원정보 수정에 실패했습니다.");
			model.addObject("location", "/member/mypageModify");
		}
		
		model.setViewName("common/msg");
		
		
		return model;
	}
	
	@GetMapping("/deleteMember")
	public String deleteMember() {
		log.info("회원 탈퇴 약관동의 페이지 요청");
		
		return "member/deleteMember";
	}
	
	// 회원 삭제
		@RequestMapping(value="/member/deleteMember")
		public ModelAndView deleteMember(ModelAndView model,
				@SessionAttribute(name="loginMember") Member loginMember,
				@RequestParam("no")int no) {
			
			 Member member = service.findMemberByNo(no);
			int result = 0;
			
			            result = service.deleteMember(loginMember.getNo());
            if(loginMember.getNo() == member.getNo()) {
                
                result = service.deleteMember(no);
                
                if(result > 0) {
                    model.addObject("msg", "정상적으로 탈퇴되었습니다.");
                    model.addObject("location", "/member/logout");                
                } else {
                    model.addObject("msg", "회원 탈퇴를 실패하였습니다.");
                model.addObject("location", "/member/mapageModify");
                    model.addObject("location", "/member/mypageModify");
                }
            } else {
                model.addObject("msg", "잘못된 접근입니다.");
                model.addObject("location", "/");
            }
			model.setViewName("common/msg");
			
			return model;
		}
	
	// 비밀번호 변경 페이지 이동
	@GetMapping("/updatePwd")
	public String updatePwd() {
		log.info("비밀번호 변경 페이지 이동");
		
		return "member/updatePwd";
	}
	
	// 비밀번호 변경 컨트롤러
	@PostMapping("/updatePwd")
	public ModelAndView updateUserPass(
			@ModelAttribute Member member, 
			ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		log.info("회원 비밀번호 변경 컨트롤러 요청");
		
		int result = 0;
		
		System.out.println(result);
		System.out.println("loginMember.getUser_id().equals(member.getUser_id()) : " + loginMember.getId().equals(member.getId()));
		System.out.println("loginMember.getUser_id() : " +  loginMember.getId() + ",  member.getUser_id() : " +  member.getId());
		System.out.println("loginMember.getUser_no() : " +  loginMember.getNo() + ",  member.getUser_no() : " +  member.getNo());
		
		/* 세팅 */
		member.setNo(loginMember.getNo());
		member.setId(loginMember.getId());
		
		System.out.println("member.getUser_no() : " + member.getNo());
		System.out.println("member.getUser_ID() : " + member.getId());
		
		result = service.updatePwd(member);
		
		System.out.println(result);
		
		if(loginMember.getId().equals(member.getId())) {
			member.setNo(loginMember.getNo());
			if(result > 0) {
				System.out.println(loginMember.getId().equals(member.getId()) + ",  result : " + result);
				model.addObject("loginMember", service.findMemberById(loginMember.getId()));
				model.addObject("msg", "비밀번호 수정을 완료했습니다.");
				model.addObject("location", "/member/mypageModify");				
			} else {
				model.addObject("msg", "비밀번호 수정에 실패 했습니다.");
				model.addObject("location", "/member/updatePwd");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		return model;
	}
	
	
	// 아이디 비밀번호 찾기 페이지 이동
	@GetMapping("/findIdOrPwd")
	public String findIdOrPwd() {
		
		log.info("아이디 비밀번호 찾기 페이지 이동!");
		
		return "member/findIdOrPwd";
	}
	
	// 아이디 찾기 페이지 이동
	@GetMapping("/findId")
	public String findId() {
		
		return "member/findId";
	}
	
	@PostMapping("/findId")
	public ModelAndView findId(
			ModelAndView model,
			@ModelAttribute Member member) {
		
		log.info("이메일 전화번호 로그 : "+ member.getEmail()+" "+member.getPhone());
		
		String findId =service.findId(member);
		
		if(findId != null) {
			model.addObject("userID" , findId);
			log.info("찾은 아이디");
			System.out.println("찾은 아이디는" + findId);
			model.addObject("msg", "찾은 아이디는 "+ findId);
			model.addObject("location", "/member/findIdOrPwd");
		}else {
			model.addObject("msg", "존재하지 않는 아이디 입니다.");
			model.addObject("location", "/member/findId");
		}
			model.setViewName("common/msg");
		
		return model;
	}
	
	// 비밀번호찾기 페이지 이동
	@GetMapping("/findPwd")
	public String findPWD() {
		
		return "member/findPwd";
	}
	
	@Autowired
    private UserMailSendService mailsender;
	
	@PostMapping("/findPwd")
	@ResponseBody
	public String findPwd(
			@RequestParam(value="id") String id,
			@RequestParam(value="email") String email,
			HttpServletRequest request) {
		
		mailsender.mailSendWithPassword(id, email, request);
		
		String alert = "메일을 확인해주세요.";
		
		return alert;
	}
	
	
	// 이미지 저장 메소드
	private String saveFile(
			MultipartFile file, 
			HttpServletRequest request) {
		
		String renamePath = null; 
		String originalFileName = null;
		String renameFileName = null;
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/profileUpload";				
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		File folder = new File(savePath); 
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		originalFileName = file.getOriginalFilename();
		renameFileName = 
				LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
				originalFileName.substring(originalFileName.lastIndexOf("."));
		renamePath = savePath + "/" + renameFileName;
		
		try {
			// 업로드한 파일을 지정한 경로에 저장해준다.
			file.transferTo(new File(renamePath));
		}catch (IOException e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	
	// 이미지 삭제 메소드
	private void deleteImg(String fileName, HttpServletRequest request) {
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/profileUpload";				
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		File file =  new File(savePath + "/" + fileName);
		
		if(file.exists()) {
			file.delete();
		}	
		
	}
	
	// 아이디 중복 체크
	@PostMapping("/idCheck")
	@ResponseBody
	public Object idCheck(@RequestParam("userId") String userId) {
		Map<String, Boolean> map = new HashMap<>();
		
		log.info("{}", userId);
		
		map.put("duplicate", service.isDuplicateID(userId));
		
		return map;
	}

}
