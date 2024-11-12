package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import Data.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditUser extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ request
        request.setCharacterEncoding("UTF-8");
        String newUsername = request.getParameter("editUsername");
        String newPassword = request.getParameter("editPassword");
        String newEmail = request.getParameter("editEmail");

        // Lấy thông tin người dùng từ session
        User user = (User) request.getSession().getAttribute("user");
        String oldUsername = user.getUsername();

        // Cập nhật thông tin người dùng
        user.setUsername(newUsername);
        user.setPassword(newPassword);
        user.setEmail(newEmail);

        // Cập nhật thông tin trong cơ sở dữ liệu
        updateUserInfoInDatabase(oldUsername, user);

        // Redirect về trang chỉnh sửa thông tin người dùng sau khi cập nhật
        response.sendRedirect("edituser.jsp");
    }

    private void updateUserInfoInDatabase(String oldUsername, User user) {
        String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "UPDATE users SET username=?, password=?, email=? WHERE username=?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, user.getUsername());
                statement.setString(2, user.getPassword());
                statement.setString(3, user.getEmail());
                statement.setString(4, oldUsername);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
