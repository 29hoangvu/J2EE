<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, Data.User, java.sql.*, Data.Book" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa sách</title>
        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="home.css"/>
        <link rel="icon" href="book.png" type="image/x-icon" />
    </head>
    <body>
        <style>
            /* CSS for the page */
            h2 {
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table th, table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            table th {
                background-color: #f2f2f2;
            }

            table tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            table tr:hover {
                background-color: #ddd;
            }
            .delete-link {
                text-decoration: none;
                color: #007bff;
            }

            .message {
                padding: 10px;
                margin-bottom: 10px;
                background-color: #f2f2f2;
                border: 1px solid #ddd;
            }

            .btn-search {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .edit-icon {
                font-size: 15px;
                color: #007bff;
                cursor: pointer;
                border: 1px solid #ddd;
            }

            #editForm {
                display: none;
                padding: 20px;
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin: 0 auto;
                width: 50%;
            }

            #editForm input {
                margin-bottom: 10px;
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            #searchInput {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                width: 300px;
                margin-right: 10px;
            }

            .btn-submit {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .btn-submit:hover {
                background-color: #45a049;
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
                    Class.forName("com.mysql.cj.jdbc.Driver");
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
                request.setAttribute("books", books);
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
            <form id="searchForm">
                <input type="text" id="searchInput" name="search" placeholder="Tìm kiếm theo tên sách...">
                <button class="btn-search" type="submit">Tìm kiếm</button>
            </form>
            <table border="1">
                <thead>
                    <tr>
                        <th>Tên sách</th>
                        <th>Tác giả</th>
                        <th>Nhà xuất bản</th>
                        <th>Trang đã đọc</th>
                        <th>Chỉnh sửa</th>
                    </tr>
                </thead>
                <tbody id="bookTableBody">
                    <% 
                        for (Book book : books) {
                    %>
                        <tr>
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getAuthor() %></td>
                            <td><%= book.getPublisher() %></td>
                            <td><%= book.getPagesRead() %></td>
                            <td>
                                <button class="edit-icon" onclick="showEditForm('<%= book.getTitle() %>', '<%= book.getAuthor() %>', '<%= book.getPublisher() %>', <%= book.getPagesRead() %>)">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </td>
                        </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="content" id="editForm">
            <h2>Chỉnh sửa thông tin sách</h2>
            <form action="./EditBook" method="post">
                <table>
                    <thead>
                        <tr>
                            <th><label for="editBookTitle">Tên sách</label></th>
                            <th><label for="editAuthor">Tác giả:</label></th>
                            <th><label for="editPublisher">Nhà xuất bản:</label></th>
                            <th><label for="editPagesRead">Trang đã đọc:</label></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <td><input type="text" id="editBookTitle" name="editBookTitle"></td>
                        <td><input type="text" id="editAuthor" name="editAuthor"></td>
                        <td><input type="text" id="editPublisher" name="editPublisher"></td>
                        <td><input type="number" id="editPagesRead" name="editPagesRead"></td>
                        <td><button type="submit" class="btn-submit">Lưu</button></td>
                    </tbody>
                </table>
            </form>
        </div>

        <script>
            // JavaScript to show edit form
            function showEditForm(title, author, publisher, pagesRead) {
                document.getElementById('editForm').style.display = 'block';
                document.getElementById('editBookTitle').value = title;
                document.getElementById('editAuthor').value = author;
                document.getElementById('editPublisher').value = publisher;
                document.getElementById('editPagesRead').value = pagesRead;
            }
        </script>

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
