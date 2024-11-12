package Servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author nvu08
 */
public class AddBookServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    // Replace with your actual database connection details
    private String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Data.User user = (Data.User) session.getAttribute("user");
        String userName = user.getUsername();

        if (userName == null || userName.isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }

        String bookTitle = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String pagesReadStr = request.getParameter("pagesRead");
        int pagesRead;
        if (pagesReadStr != null) {
            pagesRead = Integer.parseInt(pagesReadStr);
        } else {
            pagesRead = 0;
        }

        // Kết nối CSDL và kiểm tra xem tên sách đã tồn tại hay chưa
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            // Kiểm tra xem tên sách đã tồn tại trong CSDL hay chưa
            String checkSql = "SELECT COUNT(*) FROM books WHERE title = ? AND user_name = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, bookTitle);
                checkStmt.setString(2, userName);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // Chuyển hướng đến trang JSP để hiển thị thông báo
                        response.sendRedirect("hienthi.jsp");
                        return;
                    }
                }
            }

            // Nếu sách chưa tồn tại, thực hiện thêm sách vào CSDL
            String sql = "INSERT INTO books (title, author, publisher, pages_read, user_name) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, bookTitle);
                statement.setString(2, author);
                statement.setString(3, publisher);
                statement.setInt(4, pagesRead);
                statement.setString(5, userName);
                statement.executeUpdate();
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        }

        // Chuyển hướng đến trang JSP
        response.sendRedirect("hienthi.jsp");
    }
}
