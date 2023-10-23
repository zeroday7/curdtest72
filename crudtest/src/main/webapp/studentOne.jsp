<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.HashMap" %>
<!-- studentList.jsp 목록 -->
<!-- studentOne.jsp 한행의 상세 student join team -->
<!-- addStudentForm, addStudentAction, deleteStudentAction, 
	 updateStudentForm, updateStudnetAction -->
<%
	/*
	SELECT 
		s.student_no studentNo,
		s.student_name studentName,
		s.student_birth studentBirth,
		s.createdate sCreatedate,
		s.updatedate sUpdatedate,
		s.team_no teamNo,
		t.team_name teamName,
		t.team_count teamCount,
		t.team_begin teamBegin,
		t.team_end teamEnd,
		t.createdate tCreatedate,
		t.updatedate tUpdatedate
	FROM student s INNER JOIN team t
	ON s.team_no = t.team_no
	WHERE s.student_no = ?
	*/
	int studnetNo = 4; // request.getParameter("studnetNo");
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234"; 
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT s.student_no studentNo,s.student_name studentName,s.student_birth studentBirth,s.createdate sCreatedate,s.updatedate sUpdatedate,s.team_no teamNo,t.team_name teamName,t.team_count teamCount,t.team_begin teamBegin,t.team_end teamEnd,t.createdate tCreatedate,t.updatedate tUpdatedate FROM student s INNER JOIN team t ON s.team_no = t.team_no WHERE s.student_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, studnetNo);
	ResultSet rs = stmt.executeQuery();
	HashMap<String, Object> map = null;
	if(rs.next()) {
		map = new HashMap<String, Object>();
		map.put("studentNo", rs.getInt("studentNo"));
		map.put("studentName", rs.getString("studentName"));
		map.put("studentBirth", rs.getString("studentBirth"));
		map.put("sCreatedate", rs.getString("sCreatedate"));
		map.put("sUpdatedate", rs.getString("sUpdatedate"));
		map.put("teamNo", rs.getInt("teamNo"));
		map.put("teamName", rs.getString("teamName"));
		map.put("teamCount", rs.getInt("teamCount"));
		map.put("teamBegin", rs.getString("teamBegin"));
		map.put("teamEnd", rs.getString("teamEnd"));
		map.put("tCreatedate", rs.getString("tCreatedate"));
		map.put("tUpdatedate", rs.getString("tUpdatedate"));
	}
	rs.close();
	stmt.close();
	conn.close();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>학생 정보</h1>
	<table border="1">
		<tr>
			<th>studentNo</th>
			<td><%=(Integer)(map.get("studentNo"))%></td>
		</tr>
		<tr>
			<th>studentName</th>
			<td><%=(String)(map.get("studentName"))%></td>
		</tr>
		<tr>
			<th>studentBirth</th>
			<td><%=(String)(map.get("studentBirth"))%></td>
		</tr>
		<tr>
			<th>student createdate</th>
			<td><%=(String)(map.get("sCreatedate"))%></td>
		</tr>
		<tr>
			<th>studnet updatedate</th>
			<td><%=(String)(map.get("sUpdatedate"))%></td>
		</tr>
		<tr>
			<th>teamNo</th>
			<td><%=(Integer)(map.get("teamNo"))%></td>
		</tr>
		<tr>
			<th>teamName</th>
			<td><%=(String)(map.get("teamName"))%></td>
		</tr>
		<tr>
			<th>teamCount</th>
			<td><%=(Integer)(map.get("teamCount"))%></td>
		</tr>
		<tr>
			<th>teamBegin</th>
			<td><%=(String)(map.get("teamBegin"))%></td>
		</tr>
		<tr>
			<th>teamEnd</th>
			<td><%=(String)(map.get("teamEnd"))%></td>
		</tr>
		<tr>
			<th>team createdate</th>
			<td><%=(String)(map.get("tCreatedate"))%></td>
		</tr>
		<tr>
			<th>team updatedate</th>
			<td><%=(String)(map.get("tUpdatedate"))%></td>
		</tr>
	</table>
</body>
</html>