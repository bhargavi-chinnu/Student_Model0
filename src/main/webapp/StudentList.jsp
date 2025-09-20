<%@ page import="java.sql.*" %>
<html>
<head>
   <title>Model 0 Example - Student Management</title>
</head>
<body>
<h2>Student Management (Model 0 Example)</h2>

<%
   // Step 1: Load JDBC driver
   Class.forName("com.mysql.cj.jdbc.Driver");

   // Step 2: Establish connection
   Connection con = DriverManager.getConnection(
       "jdbc:mysql://127.0.0.1:3306/studentdata", "root", "Bhargavi@30");

   // Step 3: Handle insert request (if form submitted)
   String newName = request.getParameter("name");
   String newCourse = request.getParameter("course");

   if(newName != null && newCourse != null && !newName.isEmpty() && !newCourse.isEmpty()){
       PreparedStatement ps = con.prepareStatement("INSERT INTO studentsdb (name, course) VALUES (?, ?)");
       ps.setString(1, newName);
       ps.setString(2, newCourse);
       ps.executeUpdate();
       ps.close();
       out.println("<p style='color:green;'>Student added successfully!</p>");
   }

   // Step 4: Display list of students
   Statement st = con.createStatement();
   ResultSet rs = st.executeQuery("SELECT * FROM studentsdb");

   out.println("<table border='1' cellpadding='5'>");
   out.println("<tr><th>ID</th><th>Name</th><th>Course</th></tr>");
   while(rs.next()){
       out.println("<tr>");
       out.println("<td>" + rs.getInt("id") + "</td>");
       out.println("<td>" + rs.getString("name") + "</td>");
       out.println("<td>" + rs.getString("course") + "</td>");
       out.println("</tr>");
   }
   out.println("</table>");

   // Step 5: Close resources
   rs.close();
   st.close();
   con.close();
%>

<hr>

<h3>Add New Student</h3>
<form method="post" action="StudentList.jsp">
   Name: <input type="text" name="name" required><br><br>
   Course: <input type="text" name="course" required><br><br>
   <input type="submit" value="Add Student">
</form>

</body>
</html>