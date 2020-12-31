
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
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

/**
 *
 * @author m
 */
@WebServlet(urlPatterns = {"/processCheckInOut"})
public class processCheckInOut extends HttpServlet {

    private String checkIn(int reservationID, String today) throws ClassNotFoundException, SQLException {
        String result = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "UPDATE reservation SET checkInDate = ? WHERE id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, today + "");
        statement.setInt(2, reservationID );

        int s = statement.executeUpdate();
        if (s > 0) {
            result = "yes";
        } else {
            result = "no";
        }
        Con.close();

        return result ;
    }

    private String checkOut(int reservationID, String today) throws ClassNotFoundException, SQLException {
        String result = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT isPaid FROM reservation WHERE id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, reservationID + "");
        ResultSet RS = statement.executeQuery();
        RS.next();
        if (RS.getString("isPaid").compareToIgnoreCase("Yes") == 0) {
            line = "UPDATE reservation SET checkOutDate = ? WHERE id = ?";
            statement = Con.prepareStatement(line);
            statement.setString(1, today);
            statement.setInt(2, reservationID);
            int s = statement.executeUpdate();
            if (s > 0) {
                result = "yes";
            } else {
                result = "no";
            }
        }
        else{
            result = "no";
        }
        Con.close();
        return result ;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int reservationID = Integer.parseInt(request.getParameter("reservationID"));
            String today = request.getParameter("date");
            String check = request.getParameter("check");
            if(check.compareToIgnoreCase("in") == 0){
                out.print(checkIn(reservationID, today));
            }
            else if(check.compareTo("out") == 0){
                out.print(checkOut(reservationID, today));
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processCheckInOut.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processCheckInOut.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processCheckInOut.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processCheckInOut.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
