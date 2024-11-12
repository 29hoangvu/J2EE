/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editBook")
public class EditBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Replace with your actual database connection details
    private String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Lấy thông tin từ form chỉnh sửa
        String bookTitle = request.getParameter("editBookTitle");
        String author = request.getParameter("editAuthor");
        String publisher = request.getParameter("editPublisher");
        int pagesRead = Integer.parseInt(request.getParameter("editPagesRead"));

        // Kết nối CSDL và cập nhật thông tin sách
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "UPDATE books SET author=?, publisher=?, pages_read=? WHERE title=?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, author);
                statement.setString(2, publisher);
                statement.setInt(3, pagesRead);
                statement.setString(4, bookTitle);
                statement.executeUpdate();
            }

            // Chuyển hướng đến trang hiển thị thông tin sách sau khi cập nhật thành công
            response.sendRedirect("chinhsuasach.jsp");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            // Xử lý lỗi kết nối hoặc cập nhật dữ liệu
            // Điều hướng đến trang lỗi hoặc hiển thị thông báo lỗi cho người dùng
        }
    }
}
