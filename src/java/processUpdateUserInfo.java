
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/processUpdateUserInfo"})
public class processUpdateUserInfo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String id = request.getParameter("id");
            String email = request.getParameter("email");
            String Password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String source = request.getParameter("source");
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "UPDATE user SET name = ? , email = ? , phoneNumber = ? , password = ? WHERE user.id = ?";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, phone);
            statement.setString(4, Password);
            statement.setString(5, id);
            int s = statement.executeUpdate();
            Con.close();
            if (source.compareToIgnoreCase("admin") == 0) {
                response.sendRedirect("adminHome");
            } else {
                if (s > 0) {
                    out.print("yes");
                } else {
                    out.print("no");
                }
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processUpdateUserInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateUserInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processUpdateUserInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateUserInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
