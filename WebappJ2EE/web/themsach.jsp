<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Data.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm thông tin sách</title>
        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="home.css"/>
        <link rel="icon" href="book.png" type="image/x-icon" />
    </head>
    <body>
        <style>          
            h2 {
                color: #333; /* Màu tiêu đề */
            }

            form {
                margin-top: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #333; /* Màu chữ cho nhãn */
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc; /* Viền input */
                border-radius: 4px; /* Đường cong viền input */
                box-sizing: border-box; /* Kích thước tính cả padding và border */
            }

            input[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50; /* Màu nút gửi */
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049; /* Màu hover cho nút gửi */
            }
            .logout-button {
                margin-top: 0;
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
            session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("./index.html");
            }else{
        %>
        <div class="sidebar">
            <ul>
                <li><a href="home.jsp">Giới thiệu</a></li>
                <li><a href="hienthi.jsp"">Hiển thị sách</a></li>
                <li><a href="themsach.jsp" ">Thêm thông tin sách</a></li>
                <li><a href="chinhsuasach.jsp">Chỉnh sửa thông tin sách</a></li>
                <li><a href="edituser.jsp">Chỉnh sửa thông tin người dùng</a></li>
            </ul>
        </div>
        <div class="content">
            <h2>Thêm thông tin sách</h2>
            <form action="./AddBookServlet" method="post">
                <label for="bookTitle">Tên sách</label>
                <input type="text" id="bookTitle" name="bookTitle"><br><br>

                <label for="author">Tác giả</label>
                <input type="text" id="author" name="author"><br><br>

                <label for="publisher">Nhà xuất bản</label>
                <input type="text" id="publisher" name="publisher"><br><br>

                <label for="pages">Trang đã đọc</label>
                <input type="text" name="pagesRead"><br><br>

                <input type="submit" value="Thêm sách">
            </form>
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
