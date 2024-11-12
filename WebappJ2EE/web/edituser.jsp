<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="Data.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa thông tin người dùng</title>
        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="home.css"/>
        <link rel="icon" href="book.png" type="image/x-icon" />
    </head>
    <body>
        <style>
            .btn {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 5px;
            }
            button:hover {
                background-color: #45a049;
            }
            .edit-form {
                display: none;
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 5px;
                margin-top: 20px;
            }
            .edit-form label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            .edit-form input[type="text"],
            .edit-form input[type="password"],
            .edit-form input[type="email"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            .logout-button {
                margin-top: 20px;
            }

            .logout-button button {
                padding: 10px 20px;
                background-color: #dc3545;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .logout-button p {
                margin-top: 10px;
            }
        </style>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("./index.html");
            } else {
                String sessionUsername = user.getUsername(); // lấy username từ session
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    String url = "jdbc:mysql://localhost:3306/j2ee";
                    String dbUsername = "root";
                    String dbPassword = "";
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                    String query = "SELECT * FROM users WHERE username=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, sessionUsername);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String fetchedUsername = rs.getString("username");
                        String fetchedPassword = rs.getString("password");
                        String fetchedEmail = rs.getString("email");
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
            <h2>Thông tin người dùng</h2>
            <p><strong>Username:</strong> <%= fetchedUsername %></p>
            <p><strong>Password:</strong> <%= fetchedPassword %></p>
            <p><strong>Email:</strong> <%= fetchedEmail %></p>
            <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                        try { if (conn != null) conn.close(); } catch (Exception e) {}
                    }
                
            %>

            <button class="btn" onclick="showEditForm()">Chỉnh sửa</button>
            <div class="edit-form" style="display: none;">
                <h2>Chỉnh sửa thông tin user</h2>
                <form action="./EditUser" method="post">
                    <!-- Username -->
                    <label for="editUsername">Username:</label>
                    <input type="text" id="editUsername" name="editUsername" value="<%= user.getUsername() %>" readonly>

                    <!-- Password -->
                    <label for="editPassword">Password:</label>
                    <input type="password" id="editPassword" name="editPassword" value="<%= user.getPassword() %>" required>

                    <!-- Email -->
                    <label for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="editEmail" value="<%= user.getEmail() %>" required>

                    <!-- Save Button -->
                    <button class="btn" type="submit">Lưu</button>
                </form>
            </div>
            <div class="logout-button">
                <form action="./LogOut" method="get">
                    <button type="submit">Đăng xuất</button>
                </form>           
                <p>Xin chào: <%= user.getUsername() %></p>       
            </div>
        </div>
        <%
    }
        %>
        <script>
            function showEditForm() {
                document.querySelector('.edit-form').style.display = 'block';
            }
        </script>
    </body>
</html>
