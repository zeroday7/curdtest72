<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>   
    
<%
   int teamNo = Integer.parseInt(request.getParameter("teamNo"));
   System.out.println(teamNo+" <--teamNO");
   
   Class.forName("org.mariadb.jdbc.Driver");
   String url = "jdbc:mariadb://localhost:3306/gdj72";
   String dbuser = "root";
   String dbpw = "java1234";
    
   Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
   
   String sql1 = "SELECT * FROM student WHERE team_no = ?";
   PreparedStatement stmt1 = conn.prepareStatement(sql1);
   stmt1.setInt(1,teamNo);
   ResultSet rs1 = stmt1.executeQuery();
   if(rs1.next()) { // 삭제할 팀에 학생에 존재하므로 더이상 코드진행 X
	   response.sendRedirect(request.getContextPath()+"/teamList.jsp");
	   return;	
   }
   
   String sql2 = "DELETE FROM team WHERE team_no =?";
   PreparedStatement stmt2 = conn.prepareStatement(sql2);
   stmt2.setInt(1,teamNo);
   System.out.println(stmt2+" <--stmt");
   int row = stmt2.executeUpdate();
   if(row == 1) {
      System.out.println("삭제성공");
   }   else {
      System.out.println("삭제실패");
   }
   
   // db관련 프로세스 end --> DB자원 해제 <-- 모델 레이어
   stmt1.close();
   conn.close();
   

   //리다이렉션 <-- 컨트롤러 레이어
   response.sendRedirect(request.getContextPath()+"/teamList.jsp");

%>