package com.ww.mvc.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ww.mvc.board.model.service.BoardService;
import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.board.model.vo.BoardAttach;
import com.ww.mvc.board.model.vo.Reply;
import com.ww.mvc.common.util.FileProcess;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.member.model.service.MemberService;
import com.ww.mvc.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;

	@Autowired
	private ResourceLoader resourceLoader;

	// ▼ 게시판 전체보기
	@GetMapping("/list")
	public ModelAndView list(ModelAndView model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int count) {

		PageInfo pageInfo = null;
		List<Board> list = null;

		pageInfo = new PageInfo(page, 10, service.getBoardCount(), count);

		list = service.getBoardList(pageInfo);

		model.addObject("pageInfo", pageInfo);
		model.addObject("list", list);
		model.setViewName("board/list");

		return model;

	}

	// ▼ 게시글 상세조회
	@GetMapping("/view")
	public ModelAndView view(ModelAndView model, @RequestParam("no") int no) {

		Board board = service.findBoardByNo(no);
		
		int boardHits = service.getBoardHits(no);
		
		int replyCount = service.getReplyCount(no);
		
		List<BoardAttach> boardAttachlist = service.getBoardAttachList(no);
		
		List<Reply> replyList = service.getReplyList(no);
		
		board.setReplyCount(replyCount);
		board.setHits(boardHits);
		board.setReplies(replyList);
		
		log.info("상세조회" + board.toString());
		log.info("상세조회" + replyList.toString());
		
		model.addObject("replyCount", replyCount);
		model.addObject("boardHits", boardHits);
		model.addObject("board", board);
		model.addObject("boardAttachlist", boardAttachlist);
		model.addObject("replyList", replyList);
		model.setViewName("board/view");

		return model;
	}
	

	// ▼ 게시글 검색
	@GetMapping("/search")
	public ModelAndView boardSearch(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword, 
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int count) {
		ModelAndView model = new ModelAndView();
		PageInfo pageInfo = null;
		
		pageInfo = new PageInfo(page, 10, service.getSearchCount(), count);
		
		Map<String, String> searchMap = new HashMap<String, String>();
		
		searchMap.put("searchType", searchType);
		searchMap.put("keyword", keyword);
		
		List<Board> list = service.boardSearch(searchMap, pageInfo);
		
		model.addObject("searchMap", searchMap);
		model.addObject("pageInfo", pageInfo);
		model.addObject("list", list);
		model.setViewName("board/list");
		
		return model;

	}
	

	// ▼ 게시글 작성 페이지
	@GetMapping("/write")
	public String write() {
		return "/board/write";
	}
	
	
	// ▼ CKEditor 글 작성
	@RequestMapping(value="/ckUpload", method = RequestMethod.POST) 
	@ResponseBody public void ckUpload(HttpServletRequest req, HttpServletResponse res, 
			@RequestParam(required = false) MultipartFile upload) throws Exception{ 
		 
//		String uploadPath = req.getSession().getServletContext().getRealPath("/").concat("resources");
//		String uploadPath = req.getSession().getServletContext().getRealPath("/resources/ckUpload");
		String uploadPath = resourceLoader.getResource("resources/ckUpload").getFile().getPath();
		
		System.out.println("uploadPath  : " + uploadPath);
		// 랜덤 문자 생성 
		UUID uid = UUID.randomUUID(); 
		OutputStream out = null; 
		PrintWriter printWriter = null; 
		
		// 인코딩 
		res.setCharacterEncoding("utf-8"); 
		res.setContentType("text/html;charset=utf-8"); 
		try { 
			String fileName = upload.getOriginalFilename(); 
			// 파일 이름 가져오기 
			byte[] bytes = upload.getBytes(); 
			// 업로드 경로 
			String ckUploadPath = uploadPath + File.separator + uid + "_" + fileName; 
			
			out = new FileOutputStream(new File(ckUploadPath)); 
			
			out.write(bytes); 
			
			out.flush(); // out에 저장된 데이터를 전송하고 초기화 
			
			String callback = req.getParameter("CKEditorFuncNum"); 
			
			printWriter = res.getWriter(); 
			
			String fileUrl = req.getContextPath()+ "/ckUpload/" + uid + "_" + fileName; 
			
			System.out.println(fileUrl);
			
			printWriter.println("<script type='text/javascript'>"
					+ "window.parent.CKEDITOR.tools.callFunction(" 
					+ callback+",'"+ fileUrl+"','이미지를 업로드하였습니다.')" 
					+"</script>"); printWriter.flush(); 
			} catch (IOException e) {
				e.printStackTrace(); 
			
			} finally {
				try { 
					if(out != null) {
						out.close(); 
					} 
					
					if(printWriter != null) {
						printWriter.close(); 
					} 
				} catch(IOException e) {
					e.printStackTrace(); 
				} 
				
			} 
		
		return; 
		
	}
		

	// ▼ 첨부파일 글 작성
	@PostMapping("/write")
	public ModelAndView write(ModelAndView model, @ModelAttribute Board board, @SessionAttribute(name = "loginMember") Member loginMember,
			@RequestPart(value = "upfile", required = false) List<MultipartFile> upfile) throws Exception {
		
		int result = 0;

		if(upfile != null && !upfile.isEmpty()) {
			
			List<BoardAttach> attachList = new ArrayList<>();
			
			for (MultipartFile multipartFile : upfile) {
				
				log.info("upfile" + multipartFile.getOriginalFilename());
				
				String location = resourceLoader.getResource("resources/upload/board").getFile().getPath();
				String renamedFileName = FileProcess.save(multipartFile, location);
				
				BoardAttach boardAttach = new BoardAttach();
				
				if(renamedFileName != null) {
					boardAttach.setOriginalFileName(multipartFile.getOriginalFilename());
					boardAttach.setRenamedFileName(renamedFileName);
					boardAttach.setFileSize(multipartFile.getSize());
					boardAttach.setBoardNo(board.getNo());
					boardAttach.setEmpNo(loginMember.getNo());
					boardAttach.setFileNo(boardAttach.getFileNo());

				}
				
				attachList.add(boardAttach);
				
				board.setAttachList(attachList);
			}
		}
		
		board.setEmpNo(loginMember.getNo());
		result = service.save(board);
		log.info(board.toString());

		if (result > 0) {
			model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
			model.addObject("location", "/board/view?no=" + board.getNo());
		} else {
			model.addObject("msg", "게시글 등록이 실패하였습니다.");
			model.addObject("location", "/board/write");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	
	// ▼ 첨부파일 다운로드
	@GetMapping("/fileDown")
	public ResponseEntity<Resource> fileDown(
			@RequestHeader(name="user-agent") String userAgent, @RequestParam("oname") String oname, @RequestParam("rname") String rname) {
		
		String downName = null;
		Resource resource = null;
		
		resource = resourceLoader.getResource("resources/upload/board/" + rname);
		
		try {
			if(userAgent.indexOf("MSIE") != -1 || userAgent.indexOf("Trident") != -1) {
				downName = URLEncoder.encode(oname, "UTF-8").replaceAll("\\", "%20");
						
			} else {
				downName = new String(oname.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
									  .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=\"" + downName + "\"")
									  .body(resource);
		
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
			
		}
	}
	
	
	// ▼ 게시글 수정
	@GetMapping("/edit")
	public ModelAndView edit(@SessionAttribute("loginMember") Member loginMember, ModelAndView model, @RequestParam("no") int no) {
		
		Board board = service.findBoardByNo(no);
		
		List<BoardAttach> boardAttachlist = service.getBoardAttachList(no);
		
		if(loginMember.getNo() == board.getEmpNo()) {
			model.addObject("boardAttachlist", boardAttachlist);
			model.addObject("board", board);
			model.setViewName("board/edit");
		} else {
			model.addObject("msg", "접근 권한이 없습니다.");
			model.addObject("location", "/board/list");
			model.setViewName("common/msg");
		} 
		
		return model;
	}

	@PostMapping("/edit")
	public ModelAndView update(ModelAndView model, @SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Board board, @ModelAttribute BoardAttach boardAttach, HttpServletRequest request,
			@RequestPart(value = "upfile", required = false) List<MultipartFile> upfile) throws Exception {
		
		int result = 0;
		
		if(upfile != null && !upfile.isEmpty()) {

			List<BoardAttach> attachList = new ArrayList<>();

			for (MultipartFile multipartFile : upfile) {

				String location = resourceLoader.getResource("resources/upload/board").getFile().getPath();
				String renamedFileName = null;
			
				if(boardAttach.getRenamedFileName() != null) {
					
					// 기존에 업로드된 첨부파일을 삭제
					FileProcess.delete(boardAttach.getRenamedFileName(), request);
	
				}			
					
				log.info(boardAttach.getRenamedFileName());
				
				renamedFileName = FileProcess.save(multipartFile, location);

				if(renamedFileName != null) {
					
					boardAttach.setOriginalFileName(multipartFile.getOriginalFilename());
					boardAttach.setRenamedFileName(renamedFileName);
					boardAttach.setFileSize(multipartFile.getSize());
					boardAttach.setBoardNo(board.getNo());
					boardAttach.setEmpNo(loginMember.getNo());
					boardAttach.setFileNo(boardAttach.getFileNo());
					
				}
				
				attachList.add(boardAttach);
				
				board.setAttachList(attachList);

			}
		}
		
		board.setEmpNo(loginMember.getNo());

		result = service.save(board);
		
		log.info(board.toString());

		if (result > 0) {
			model.addObject("msg", "게시글이 정상적으로 수정되었습니다.");
			model.addObject("location", "/board/view?no=" + board.getNo());
		} else {
			model.addObject("msg", "게시글 수정이 실패하였습니다.");
			model.addObject("location", "/board/write");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	// ▼ 파일 삭제
	@GetMapping("/fileDelete")
	public ModelAndView deleteFile(ModelAndView model, @RequestParam("no") int no, 
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int result = 0;
		
		BoardAttach boardAttach = service.findBoardAttachByNo(no);
		
		if (boardAttach != null) {
			result = service.deleteFile(no);
		
			if(result > 0) {
				model.addObject("msg", "파일 삭제 완료!");	
				model.addObject("location", "/board/edit?no=" + boardAttach.getBoardNo());
			} else {
				model.addObject("msg", "파일 삭제 실패!");
				model.addObject("location", "/board/edit?no=" + boardAttach.getBoardNo());
			}
			
		} else {
			
			model.addObject("msg", "잘못된 요청입니다.");
			model.addObject("location", "/board/list");
			
		}
		
		model.setViewName("/common/msg");
		
		return model;
	}
	
	
	// ▼ 게시글 삭제
	@GetMapping("/delete")
	public ModelAndView delete(ModelAndView model, @SessionAttribute("loginMember") Member loginMember, @RequestParam("no") int no) {
		
		Board board = service.findBoardByNo(no);
		
		int result = 0;
		
		if(loginMember.getNo() == board.getEmpNo()) {
			
			result = service.delete(board.getNo());
			
			if(result > 0) {
				model.addObject("msg", "게시글이 정상적으로 삭제되었습니다.");
				model.addObject("location", "/board/list");
			} else {
				model.addObject("msg", "게시글 삭제가 실패했습니다.");
				model.addObject("location", "/board/view?no=" + board.getNo());
			}
			
		} else {
			model.addObject("msg", "본인 게시글만 삭제할 수 있습니다.");
			model.addObject("location", "/board/list");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	
	// ▼ 댓글 작성
	@RequestMapping("/reply")
	public ModelAndView writeReply(ModelAndView model, @ModelAttribute Board board, @SessionAttribute("loginMember") Member loginMember, Reply reply) {
		
		int result = 0;
		
		log.info("댓글 작성" + loginMember.toString());
		
		reply.setBoardNo(board.getNo());
		reply.setEmpNo(loginMember.getNo());
		reply.setWriter(loginMember.getName());
		
		int boardNo = reply.getBoardNo();

		result = service.saveReply(loginMember, reply);
		
		log.info("댓글 작성" + reply.toString());
		
		if(result > 0) {
			model.addObject("msg", "댓글 등록 완료!");
			model.addObject("location", "/board/view?no=" + boardNo);
		} else {
			model.addObject("msg", "댓글 등록 실패!");
			model.addObject("location", "/board/view?no=" + boardNo);	
			
		}
		
		model.setViewName("/common/msg");
		
		return model;
	}
	
	
	
	// ▼ 댓글 수정
	@GetMapping("/replyEdit")
	public ModelAndView replyEdit(@SessionAttribute("loginMember") Member loginMember, ModelAndView model, @RequestParam("no") int no) {
		
		Board board = service.findBoardByNo(no);
		
		log.info(loginMember.toString());
		log.info(board.toString());
		
		if(loginMember.getNo() == board.getEmpNo()) {
			model.addObject("board", board);
			model.setViewName("board/replyEdit");
		} else {
			model.addObject("msg", "접근 권한이 없습니다.");
			model.addObject("location", "/board/list");
			model.setViewName("common/msg");
		} 
		
		return model;
	}
	
	
	@PostMapping("/replyUpdate")
	public ModelAndView updateReply(ModelAndView model, @ModelAttribute Board board, @SessionAttribute("loginMember") Member member, Reply reply,
			@RequestParam("boardNo") int no, @RequestParam("content") String content) {
		int result = 0;
		
		board = service.findBoardByNo(no);
		
		reply.setNo(reply.getNo());
		reply.setBoardNo(no);
		reply.setEmpNo(member.getNo());
		reply.setContent(content);
		
		result = service.updateReply(reply);
		
		log.info(reply.toString());
		
		if(result > 0) {
			model.addObject("msg", "댓글 수정 완료!");
			model.addObject("location", "/board/view?no=" + no);
		} else {
			model.addObject("msg", "댓글 수정 실패!");
			model.addObject("location", "/board/view?no=" + no);	
			
		}
		
		model.setViewName("/common/msg");
		
		return model;
		
	}
	

	// ▼ 댓글 삭제
	@GetMapping("/replyDelete")
	public ModelAndView deleteReply(ModelAndView model, @SessionAttribute("loginMember") Member loginMember, @RequestParam("no") int no) {
		
		int result = 0;
		
		Reply reply = service.findReplyByNo(no);
		
		int boardNo = reply.getBoardNo();

		if(reply != null) {
			
			result = service.deleteReply(no);
			
			if(result > 0) {
				model.addObject("msg", "댓글 삭제 완료!");
				model.addObject("location", "/board/view?no=" + boardNo);
			} else {
				model.addObject("msg", "댓글 삭제 실패!");
				model.addObject("location", "/board/list");
			}
			
		}
		
		model.setViewName("/common/msg");
		
		return model;
	

	}
	
	

	

}
