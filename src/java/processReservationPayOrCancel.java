
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns = {"/processReservationPayOrCancel"})
public class processReservationPayOrCancel extends HttpServlet {
        
    private String processPayment(int resID) throws ClassNotFoundException, SQLException{
        String tempResult = "no", result = "yes" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "UPDATE reservation SET reservation.isPaid = ? WHERE id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, "Yes");
        statement.setInt(2, resID);
        int s = statement.executeUpdate();
        if(s <= 0)  result = tempResult ;   
        Con.close();
        return result ;
    }
    
    private String processCancel(int resID) throws ClassNotFoundException, SQLException{
        String tempResult = "no", result = "yes" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "DELETE FROM reservation WHERE reservation.id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, resID);
        int s = statement.executeUpdate();
        if(s <= 0)  result = tempResult ;   
        Con.close();
        return result ;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int resID = Integer.parseInt(request.getParameter("reservationID"));
            String operation = request.getParameter("operation");
            if(operation.compareToIgnoreCase("pay") == 0){
                out.print(processPayment(resID));
            }
            else if(operation.compareToIgnoreCase("cancel") == 0){
                out.print(processCancel(resID));
            }
        }
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processViewReservations.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processViewReservations.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processViewReservations.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processViewReservations.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
