package com.ww.mvc.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ww.mvc.board.model.dao.BoardMapper;
import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.board.model.vo.BoardAttach;
import com.ww.mvc.board.model.vo.Reply;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.member.model.vo.Member;

@Service
public class BoardServieImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	// ▼ 게시글 전체 개수
	@Override
	public int getBoardCount() {
		
		return mapper.getBoardCount();
	}

	// ▼ 게시글 목록 조회
	@Override
	public List<Board> getBoardList(PageInfo pageInfo) {
		
		 int offset = (pageInfo.getCurrentPage() - 1 ) * pageInfo.getListLimit();
		 int limit = pageInfo.getListLimit();
		 RowBounds rowBounds = new RowBounds(offset, limit);

		 return mapper.findAll(rowBounds);
		 
	}

	// ▼ 게시글 상세 조회
	@Override
	public Board findBoardByNo(int no) {
		
		return mapper.selectBoardByNo(no);
	}

	
	// ▼ 게시글 수정, 게시글 작성
	@Override
	@Transactional
	public int save(Board board) {
	int result = 0;
		
		if(board.getNo() != 0) {
			// update
			result = mapper.updateBoard(board);
		} else {
			// insert
			result = mapper.insertBoard(board);
		}
		
//		 Attach는 n개면 n번 insert
		for(BoardAttach boardAttach : board.getAttachList()) {
			mapper.insertFile(boardAttach);
		}
		
		return result;
	}

	
	// ▼ 게시글 검색
	@Override
	public List<Board> boardSearch(Map<String, String> searchMap, PageInfo pageInfo) {
		
		int offset = (pageInfo.getCurrentPage() - 1 ) * pageInfo.getListLimit();
		int limit = pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return mapper.searchBoard(rowBounds, searchMap);
	}

	
	// ▼ 게시글 검색 전체 개수
	@Override
	public int getSearchCount() {
		
		return mapper.searchCount();
	}

	
	// ▼ 게시글 삭제
	@Override
	public int delete(int no) {
		
		return mapper.deleteBoard(no);
	}

	// ▼ 게시글 조회수
	@Override
	public int getBoardHits(int no) {
		
		return mapper.plusHits(no);
	}

	
	// ▼ 댓글 작성
	@Override
	@Transactional
	public int saveReply(Member loginMember, Reply reply) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("content", reply.getContent());
		map.put("boardNo", reply.getBoardNo());
		map.put("empNo", loginMember.getNo());
		map.put("writer", loginMember.getName());
		
		return mapper.insertReply(map);
	}

	
	// ▼ 댓글 삭제
	@Override
	public int deleteReply(int no) {
		
		return mapper.deleteReply(no);
	}
	

	// ▼ 댓글 수정
	@Override
	public int updateReply(Reply reply) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("content", reply.getContent());
		map.put("no", reply.getNo());
		map.put("writer", reply.getWriter());
		
		return mapper.updateReply(map);
		
	}
	
	
	// ▼ 댓글 개수
	@Override
	public int getReplyCount(int no) {
		
		return mapper.getReplyCount(no);
	}

	
	// ▼ 첨부파일 리스트 조회
	@Override
	public List<BoardAttach> getBoardAttachList(int no) {
		
		return mapper.findByBoardNo(no);
	}

	
	// ▼ 첨부파일 삭제
	@Override
	public int deleteFile(int no) {
		
		return mapper.deleteFile(no);
	}

	@Override
	public BoardAttach findBoardAttachByNo(int no) {
		
		return mapper.selectBoardAttachByNo(no);
		
	}

	@Override
	public Reply findReplyByNo(int no) {
		
		return mapper.selectReplyByNo(no);
	}

	@Override
	public List<Reply> getReplyList(int no) {
		
		return mapper.selectReplyListByNo(no);
	}



	
	

}
