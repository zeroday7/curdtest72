<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Board" %>

<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	Class.forName("org.mariadb.jdbc.Driver");  // 드라이브 로딩
	System.out.println("드라이브 로딩성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";  // 마리아 디비 접속
	String dbuser = "root";                              // 이름
	String dbpw = "java1234";

	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate, updatedate FROM board WHERE board_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	Board board = null;
	
	if(rs.next()){
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.boardTitle = rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.boardWriter = rs.getString("boardWriter");
		board.createdate= rs.getString("createdate");
		board.updatedate = rs.getString("updatedate");
	}

	rs.close();
	stmt.close();
	conn.close();
	
	// Model Layer
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>상세보기</h1>
	<table border="1">
		<tr>
			<th>board_title</th>
			<td><%=board.boardTitle%>
		</tr>
		<tr>
			<th>board_content</th>
			<td><%=board.boardContent%>
		</tr>
		<tr>
			<th>board_writer</th>
			<td><%=board.boardWriter%>
		</tr>
		<tr>
			<th>createdate</th>
			<td><%=board.createdate%>
		</tr>
		<tr>
			<th>updatedate</th>
			<td><%=board.updatedate%>
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=board.boardNo%>">
			수정
		</a>
		<!-- 
			updateBoardForm.jsp : 수정필드와 비밀번호 입력
			updateBoardAction.jsp : update .... where board_no = ? and board_pw = ?
		 -->
		
		<a href="<%=request.getContextPath()%>/deleteBoardForm.jsp?boardNo=<%=board.boardNo%>">
			삭제
		</a>
		<!-- 
			deleteBoardForm.jsp : 비밀번호 입력
			deleteBoardAction.jsp : delete .... where board_no = ? and board_pw = ?
		 -->
	</div>
</body>
</html>