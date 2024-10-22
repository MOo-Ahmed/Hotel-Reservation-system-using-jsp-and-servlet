
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
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/processLogin"})
public class processLogin extends HttpServlet {

    private boolean isAdmin(int id) throws ClassNotFoundException, SQLException {
        boolean result = false;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT * FROM user WHERE id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, id + "");
        ResultSet RS = statement.executeQuery();
        RS.next();
        if (RS.getBoolean("isAdmin") == true) {
            result = true ;
            
        }
        Con.close();
        return result;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String PASSWORD = request.getParameter("password");
            String username = request.getParameter("username");
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "SELECT * FROM user WHERE username = ? AND password = ?";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setString(1, username + "");
            statement.setString(2, PASSWORD + "");

            HttpSession session = request.getSession(true);
            ResultSet RS = statement.executeQuery();
            if (RS.next()) {
                boolean isAdmin = isAdmin(RS.getInt("id"));
                if (isAdmin) {
                    session.setAttribute("adminID", RS.getInt("id"));
                    out.print("admin");
                    
                } else {
                    session.setAttribute("userID", RS.getInt("id"));
                    out.print("yes");
                }
            } else {
                out.print("no");
            }
            Con.close();

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processLogin.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
