<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Data.Book" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Lấy tên sách từ request parameter
    request.setCharacterEncoding("UTF-8");
    String bookName = request.getParameter("bookName");
    if (bookName != null && !bookName.isEmpty()) {
        try {
            // Kết nối CSDL và thực hiện xóa sách
            String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
            String jdbcUsername = "root";
            String jdbcPassword = "";
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "DELETE FROM books WHERE title=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, bookName);
            statement.executeUpdate();
            conn.close();
            // Chuyển hướng về trang hiển thị sau khi xóa thành công
            response.sendRedirect("hienthi.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần thiết
        }
    }
%>
