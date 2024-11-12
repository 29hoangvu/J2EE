package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

//@WebServlet("/Adduser")
public class Adduser extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Replace with your actual database connection details
    private String jdbcURL = "jdbc:mysql://localhost:3306/j2ee";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Validate and connect to database (replace with your validation logic)
        if (username != null && password != null && email != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                // Check if username already exists
                String checkUsernameQuery = "SELECT * FROM users WHERE username=?";
                PreparedStatement checkStatement = connection.prepareStatement(checkUsernameQuery);
                checkStatement.setString(1, username);
                ResultSet resultSet = checkStatement.executeQuery();

                if (resultSet.next()) {
                    // Username already exists, display error message
                    out.println("<script>");
                    out.println("alert('Dang ki that bai, ten dang nhap da ton tai!');");
                    out.println("window.location.href = 'dangky.html';"); // Redirect to index.jsp
                    out.println("</script>");

                } else {
                    // Username does not exist, proceed with registration
                    // Prepare SQL statement
                    String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, username);
                    statement.setString(2, password);
                    statement.setString(3, email);

                    // Execute statement and handle success/failure
                    int rowsInserted = statement.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<script>");
                        out.println("alert('Dang ky thanh cong!');");
                        out.println("window.location.href = 'index.html';"); // Redirect to index.jsp
                        out.println("</script>");
                    } else {
                        out.println("<p>Sorry, user registration failed!</p>");
                    }
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Please fill out all required fields!</p>");
        }
    }
}
