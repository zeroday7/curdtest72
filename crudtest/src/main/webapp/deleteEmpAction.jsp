<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	System.out.println(empNo + " <-- empNo");

	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM emp WHERE emp_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, empNo);
	System.out.println(stmt +" <-- stmt");
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("삭제성공");
	}	else {
		System.out.println("삭제실패");
	}
	stmt.close();
	conn.close();
	//리다이렉션 <-- 컨터롤러 레이어
	response.sendRedirect(request.getContextPath()+"/empList.jsp");
%>