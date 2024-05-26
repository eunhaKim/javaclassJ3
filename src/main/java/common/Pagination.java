package common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import board.BoardDAO;
import board.BoardVO;

public class Pagination {

	public static void pageChange(HttpServletRequest request, int pag, int pageSize, String contentsShow, String bName, String search) {
		BoardDAO boardDao = new BoardDAO();
		
		// search/searchString 의 값이 넘어올경우
		String searchField = "", searchString = "";
		if(search != null && !search.equals("")) {
			searchField = search.split("/")[0];
			searchString = search.split("/")[1];
		}
		
		int totRecCnt = 0;
		
		if(search == null || search.equals("")) {
		  totRecCnt = boardDao.getTotRecCnt(contentsShow, bName, "", "");	// 게시판의 전체/조건에 따른 레코드수 구하기
		}
		else {
			totRecCnt = boardDao.getTotRecCnt(contentsShow, bName, searchField, searchString);	// 게시판의 전체/조건에 따른 레코드수 구하기
		}
		
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<BoardVO> boardVos = null;
		
		if(search == null || search.equals("")) {
			boardVos = boardDao.getBoardList(startIndexNo, pageSize, contentsShow, bName, "", "");	// 게시판의 전체 자료 가져오기
		}
		else {
			boardVos = boardDao.getBoardList(startIndexNo, pageSize, contentsShow, bName, searchField, searchString);
		}
		request.setAttribute("vos", boardVos);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("bName", bName);
		
		if(search != null && !search.equals("")) {
			String searchTitle = "";
			if(searchField.equals("title")) searchTitle = "글제목";
			else if(searchField.equals("nickName")) searchTitle = "글쓴이";
			else searchTitle = "글내용";
			request.setAttribute("searchField", searchField);
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("searchString", searchString);
			request.setAttribute("searchCount", totRecCnt);
		}
	}


}
