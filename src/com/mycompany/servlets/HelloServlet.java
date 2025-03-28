import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/submitUser")
public class HelloServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Validate the data
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().println("<h3>Error: Name and Email are required fields!</h3>");
            return;
        }

        try {
            // Insert the user into the database and check success
            boolean success = DatabaseConnection.insertUser(name, email);

            // Respond to the client
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (success) {
                out.println("<h3>User added successfully!</h3>");
                out.println("<a href='index.jsp'>Go back</a>");
            } else {
                out.println("<h3>Error: Failed to add the user.</h3>");
                out.println("<a href='index.jsp'>Go back</a>");
            }
        } catch (Exception e) {
            // Handle any database connection issues
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("<h3>Error: Unable to add user due to a server issue. Please try again later.</h3>");
            e.printStackTrace();
        }
    }
}
