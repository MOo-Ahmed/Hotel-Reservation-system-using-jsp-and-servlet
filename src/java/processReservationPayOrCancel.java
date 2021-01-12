
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
    
    private String processCancel(int resID, String notify) throws ClassNotFoundException, SQLException{
        String result = "yes" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        // Before deleting the reservation tuple, we gotta get its info to send a notification
        if(notify.compareToIgnoreCase("true") == 0){
            
            String line = "SELECT hotel.id AS HotelID, hotel.name AS HotelName, reservation.startDate AS StartDate, reservation.endDate AS EndDate,"
                + " user.name AS ClientName FROM reservation INNER JOIN hotel ON reservation.hotelID = hotel.id INNER JOIN user"
                + " ON user.id = reservation.userID AND reservation.id = ?";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setInt(1, resID);
            ResultSet RS = statement.executeQuery(); 
            if(RS.next()){
                String start = String.valueOf(RS.getDate("StartDate"));
                String end = String.valueOf(RS.getDate("EndDate"));
                String name = RS.getString("ClientName");
                String hotelName = RS.getString("HotelName");
                int hotelID = RS.getInt("HotelID");
                
                line = "INSERT INTO notification(content, hotelID) VALUES (? , ?)" ;
                String notification = "Reservation with id = " + resID + " at hotel '" + hotelName + "' , and start date = " 
                        + start + " and end date = " + end + " , has been cancelled by client whose name is " + name + "" ;
                
                statement = Con.prepareStatement(line);
                statement.setString(1, notification);
                statement.setInt(2, hotelID);
                int s = statement.executeUpdate();
                
                line = "SELECT user.email AS Email FROM user INNER JOIN hoteladmin ON user.id = hoteladmin.adminID AND hotelID = ?" ;
                statement = Con.prepareStatement(line);
                statement.setInt(1, hotelID);
                RS = statement.executeQuery(); 
                while(RS.next()){
                    String adminEmail = RS.getString("Email");
                    String message = "Dear admin, we'd like to inform you that\n" + notification ;
                    MailSender.sendMail(adminEmail, "Reservation got cancelled", message);
                }
                
            }
        }
        
        
        String line = "DELETE FROM roomreservation WHERE reservationID = ?";
        PreparedStatement statement2 = Con.prepareStatement(line);
        statement2.setInt(1, resID);
        int s = statement2.executeUpdate();
        line = "DELETE FROM reservation WHERE reservation.id = ?";
        statement2 = Con.prepareStatement(line);
        statement2.setInt(1, resID);
        s = statement2.executeUpdate();
        if(s <= 0)  result = "no" ;
        else    result = "yes";
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
                String notify = request.getParameter("notify");
                out.print(processCancel(resID, notify));
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
