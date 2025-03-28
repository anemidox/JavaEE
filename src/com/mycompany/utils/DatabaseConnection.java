import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/java";
    private static final String USER = "root";
    private static final String PASSWORD = "dhanujatoor";

    // Modify insertUser method to return a boolean indicating success or failure
    public static boolean insertUser(String name, String email) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO users (name, email) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);

                int rowsInserted = stmt.executeUpdate();
                return rowsInserted > 0; // Return true if rows are inserted, false otherwise
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;  // Return false if an exception occurs
        }
    }
}
