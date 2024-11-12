<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="Data.User" %>
<%@page import="java.sql.*, Data.Book" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin sách của bạn</title>
        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="home.css"/>
        <link rel="icon" href="book.png" type="image/x-icon" />
    </head>
    <body>
        <style>
            h2 { color: #333; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            table th, table td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            table th { background-color: #f2f2f2; }
            table tr:nth-child(even) { background-color: #f2f2f2; }
            table tr:hover { background-color: #ddd; }
            .delete-link { text-decoration: none; color: #007bff; }
            .message { padding: 10px; margin-bottom: 10px; background-color: #f2f2f2; border: 1px solid #ddd; }
            .btn-dl-all { padding: 10px 20px; background-color: aqua; border: none; border-radius: 4px; cursor: pointer; }
            .logout-button { margin-top: 20px; }
            .logout-button button { padding: 10px 20px; background-color: #dc3545; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
            .logout-button p { margin-top: 10px; }
        </style>
        <%
            session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("./index.html");
            } else {
                List<Book> books = new ArrayList<>();
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                String userName = user.getUsername();
                try {
                    String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
                    String jdbcUsername = "root";
                    String jdbcPassword = "";
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM books WHERE user_name='" + user.getUsername() + "'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        Book book = new Book();
                        book.setTitle(rs.getString("title"));
                        book.setAuthor(rs.getString("author"));
                        book.setPublisher(rs.getString("publisher"));
                        book.setPagesRead(rs.getInt("pages_read"));
                        books.add(book);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
        %>

        <div class="sidebar">
            <ul>
                <li><a href="home.jsp">Giới thiệu</a></li>
                <li><a href="hienthi.jsp">Hiển thị sách</a></li>
                <li><a href="themsach.jsp">Thêm thông tin sách</a></li>
                <li><a href="chinhsuasach.jsp">Chỉnh sửa thông tin sách</a></li>
                <li><a href="edituser.jsp">Chỉnh sửa thông tin người dùng</a></li>
            </ul>
        </div>

        <div class="content">
            <h2>Thông tin sách của bạn</h2>
            <form action="./DeleteAllBooks" method="get" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tất cả sách?')">
                <button class="btn-dl-all" type="submit">Xóa tất cả</button>
            </form>
            <table border="1">
                <thead>
                    <tr>
                        <th>Tên sách</th>
                        <th>Tác giả</th>
                        <th>Nhà xuất bản</th>
                        <th>Trang đã đọc</th>
                        <th>Xóa</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Book book : books) { %>
                        <tr>
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getAuthor() %></td>
                            <td><%= book.getPublisher() %></td>
                            <td><%= book.getPagesRead() %></td>
                            <td><a class="delete-link" href="deleteBook.jsp?bookName=<%= book.getTitle() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa sách này không?')">&#128465;</a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="logout-button">
            <form action="./LogOut" method="get">
                <button onclick="logout()">Đăng xuất</button>
            </form>
            <p>Xin chào: <%= user.getUsername() %></p>
        </div>
        <%
            }
        %>
    </body>
</html>
