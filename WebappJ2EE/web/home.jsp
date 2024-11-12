<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Data.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giới thiệu - Trang Quản lý Đọc Sách</title>
        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="home.css"/>
        <link rel="icon" href="book.png" type="image/x-icon" />
    </head>
    <body>
        <% 
            session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("index.html");
            }else{
        %>
        <style>
            .logout-button {
                margin-top: 10px;
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
        <div class="sidebar">
            <ul>
                <li><a href="home.jsp">Giới thiệu</a></li>
                <li><a href="hienthi.jsp">Hiển thị sách</a></li>
                <li><a href="themsach.jsp">Thêm thông tin sách</a></li>
                <li><a href="chinhsuasach.jsp">Chỉnh sửa thông tin sách</a></li>
                <li><a href="edituser.jsp">Chỉnh sửa thông tin người dùng</a></li>
            </ul>
        </div>
        <div class="container">

            <div class="content" id="home">
                <h2>Giới thiệu về trang Quản Lý Đọc Sách</h2>
                <p>Trang Quản lý Đọc Sách là một ứng dụng web được thiết kế để giúp người dùng quản lý và theo dõi tiến độ đọc sách của mình một cách hiệu quả. Với các tính năng đa dạng và thuận tiện, trang web này cung cấp một nền tảng đáng tin cậy để tổ chức và tận dụng những trải nghiệm đọc sách tốt nhất.</p>
                <h3>Các chức năng và tính năng:</h3>
                <ol>
                    <li><strong>Nhập Tiến Độ Đọc Sách</strong></li>
                    <ul>
                        <li>Người dùng có thể dễ dàng nhập tiến độ đọc sách của mình bằng cách cập nhật thông tin về số trang đã đọc, thời gian đọc, hoặc tiến độ theo phần trăm.</li>
                        <li>Các trường thông tin bổ sung như đánh giá, nhận xét cũng có thể được thêm vào để người dùng có thể ghi chú và phản hồi về sách một cách tổ chức.</li>
                    </ul>
                    <li><strong>Hiển Thị Sách Đã Đọc</strong></li>
                    <ul>
                        <li>Trang web cho phép người dùng xem danh sách các cuốn sách đã đọc, bao gồm thông tin chi tiết về tiến độ đọc, tác giả, nhà xuất bản và các thông tin khác.</li>
                        <li>Người dùng có thể dễ dàng tìm kiếm sách và sắp xếp theo tiêu chí khác nhau như tựa đề, tác giả, hoặc thể loại.</li>
                    </ul>
                    <li><strong>Chỉnh Sửa Thông Tin Sách</strong></li>
                    <ul>
                        <li>Chức năng này cho phép người dùng chỉnh sửa thông tin về các cuốn sách đã đọc, bao gồm cập nhật số trang đã đọc, thời gian đọc, nhận xét và đánh giá.</li>
                        <li>Người dùng cũng có thể xóa hoặc sửa đổi thông tin sách một cách linh hoạt.</li>
                    </ul>
                    <li><strong>Chỉnh Sửa Thông Tin Người Dùng</strong></li>
                    <ul>
                        <li>Chức năng này cho phép người dùng chỉnh sửa thông tin cá nhân, bao gồm tên người dùng, mật khẩu và thông tin liên hệ khác.</li>
                        <li>Người dùng có thể cập nhật thông tin của họ một cách dễ dàng để giữ cho hồ sơ cá nhân luôn được cập nhật.</li>
                    </ul>
                    <li><strong>Lợi Ích</strong></li>
                    <ul>
                        <li>Quản lý tiến độ đọc sách một cách tổ chức và hiệu quả.</li>
                        <li>Tăng cường khả năng theo dõi và kiểm soát việc đọc sách.</li>
                        <li>Tạo danh sách sách yêu thích và sách đã đọc để tiện lợi trong việc tìm kiếm và truy cập.</li>
                        <li>Đề xuất sách mới dựa trên sở thích và lịch sử đọc sách cá nhân.</li>
                        <li>Tạo ra một môi trường đọc sách trực tuyến thuận tiện và linh hoạt.</li>
                    </ul>
                </ol>
            </div>
            <div class="logout-button">
                <form action="./LogOut" method="get">
                    <button onclick="logout()">Đăng xuất</button>
                </form>           
                <p>Xin chào: <%= user.getUsername() %></p>       
            </div>
        </div>
        <%
    }
        %>
    </body>
</html>
