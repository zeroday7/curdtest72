<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Emp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT emp_no AS empNo, emp_name AS empName, createdate, updatedate FROM emp";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	// <-- 모델 레이어
	// 자원해제? 자원을 뷰에서 사용하는데? 해제전에 ResultSet -> ArrayList로 변형카피 -> 자원해제
	// DB Emp테이블 행의 집합(ResultSet)을 -> JAVA Emp클래스 타입의 집합(ArrayList)으로		
	ArrayList<Emp> list = new ArrayList<Emp>();
	while(rs.next()) {
		Emp e = new Emp(); // 결과행의 수만큼 Emp객체 필요
		e.empNo = rs.getInt("empNo");
		e.empName = rs.getString("empName");
		e.createdate = rs.getString("createdate");
		e.updatedate = rs.getString("updatedate");
		list.add(e);
	}
	
	// 뷰 레이어
	
%>

	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
	</ul>
	
	<h1>직원 리스트</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addEmpForm.jsp">직원추가</a>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>emp_no</th>
				<th>emp_name</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Emp e : list) {
			%>
					<tr>
						<td><%=e.empNo%></td>
						<td><%=e.empName%></td>
						<td><%=e.createdate%></td>
						<td><%=e.updatedate%></td>
						<td>
							<a href="<%=request.getContextPath()%>/updateEmpForm.jsp?empNo=<%=e.empNo%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/deleteEmpAction.jsp?empNo=<%=e.empNo%>">삭제</a>
						</td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>