package Servlet;
import Data.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteAllBooks extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy người dùng hiện tại từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra xem người dùng có null hay không
        if(user != null) {
            // Xóa thông tin sách của người dùng từ cơ sở dữ liệu
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
                String jdbcUsername = "root";
                String jdbcPassword = "";
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                
                // Thực hiện xóa
                String sql = "DELETE FROM books WHERE user_name=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, user.getUsername());
                stmt.executeUpdate();
                
                // Chuyển hướng người dùng sau khi xóa xong
                response.sendRedirect("hienthi.jsp"); // hoặc trang nào bạn muốn
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Đóng kết nối CSDL
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Nếu không có người dùng trong session, không thực hiện gì cả hoặc thông báo lỗi
            // Ví dụ:
            response.getWriter().println("Không tìm thấy thông tin người dùng trong session");
        }
    }
}
