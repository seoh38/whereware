package com.ww.mvc.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.board.model.vo.BoardAttach;
import com.ww.mvc.board.model.vo.Reply;

@Mapper
public interface BoardMapper {

	int getBoardCount();

	List<Board> findAll(RowBounds rowBounds);

	Board selectBoardByNo(int no);

	int updateBoard(Board board);

	int insertBoard(Board board);

	List<Board> searchBoard(RowBounds rowBounds, Map<String, String> searchMap);

	int searchCount();

	void insertFile(BoardAttach boardAttach);

	int deleteFile(int no);

	int deleteBoard(int no);

	int insertReply(Map<Object, Object> map);

	int deleteReply(int no);

	int updateReply(Map<Object, Object> map);

	int getReplyCount(int no);

	int plusHits(int no);

	List<BoardAttach> findByBoardNo(int no);

	BoardAttach selectBoardAttachByNo(int no);

	Reply selectReplyByNo(int no);

	List<Reply> selectReplyListByNo(int no);



	



}
