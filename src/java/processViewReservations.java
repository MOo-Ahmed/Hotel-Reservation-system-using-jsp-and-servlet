
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


@WebServlet(urlPatterns = {"/processViewReservations"})
public class processViewReservations extends HttpServlet {
    private String getCuurentReservations(int hotelID) throws ClassNotFoundException, SQLException {
        String tempResult = "No reservations at this period", result = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT reservation.id AS ReservationID, reservation.userID AS UserID, reservation.isPaid AS isPaid, "
                + " reservation.startDate AS StartDate, reservation.endDate AS EndDate, user.name AS ClientName"
                + " FROM reservation INNER JOIN user ON reservation.userID = user.id AND reservation.checkOutDate IS NULL AND reservation.hotelID = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, hotelID);
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        result += "<table><tr><th>Reservation ID</th><th>User ID</th> <th>User Name</th><th>Start</th><th>End</th> <th>Pay</th><th>Cancel</th></tr>" ;
        while(RS.next()){
            // Here we should print a table with cancel buttons and confoirm payment buttons
            empty = false ;
            //result += "<label>" + (i++) +  "</label><button class='btn form-btn btn-purple'>Cancel this</button><br>";
            int rID = RS.getInt("ReservationID") ;
            int uID = RS.getInt("UserID") ;
            String uName = RS.getString("ClientName") ;
            String start = RS.getString("StartDate") ;
            String end = RS.getString("EndDate") ;
            String isPaid = RS.getString("isPaid") ;
            result += getTableRow(rID, uID, isPaid, start, end, uName, true);
            
        }
        if(empty)   result = tempResult ;
        else    result += "</table>" ;
        Con.close();
        return result ;
    }
    
    private String getSpecificReservations(int hotelID, String from, String to) throws ClassNotFoundException, SQLException {
        String tempResult = "No reservations yet", result = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT reservation.id AS ReservationID, reservation.userID AS UserID, reservation.isPaid AS isPaid, "
                + " reservation.startDate AS StartDate, reservation.endDate AS EndDate, user.name AS ClientName"
                + " FROM reservation INNER JOIN user ON reservation.userID = user.id "
                + "AND reservation.hotelID = ? AND reservation.startDate >= ? AND reservation.endDate <= ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, hotelID);
        statement.setString(2, from);
        statement.setString(3, to);

        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        result += "<table><tr><th>Reservation ID</th><th>User ID</th> <th>User Name</th><th>Start</th><th>End</th> <th>Is Paid</th></tr>" ;
        while(RS.next()){
            // Here we should print a table with cancel buttons and confoirm payment buttons
            empty = false ;
            //result += "<label>" + (i++) +  "</label><button class='btn form-btn btn-purple'>Cancel this</button><br>";
            int rID = RS.getInt("ReservationID") ;
            int uID = RS.getInt("UserID") ;
            String uName = RS.getString("ClientName") ;
            String start = RS.getString("StartDate") ;
            String end = RS.getString("EndDate") ;
            String isPaid = RS.getString("isPaid") ;
            result += getTableRow(rID, uID, isPaid, start, end, uName, false);
            
        }
        if(empty)   result = tempResult ;
        else    result += "</table>" ;
        Con.close();
        return result ;
    }
    
    private String getTableRow(int rID, int uID, String isPaid, String start, String end, String uName, boolean isControllable){
        // reservationID -> userID -> username -> start -> end -> pay -> cancel
        String result = "<tr>" ;
        result += "<td>" + rID + "</td><td>" + uID + "</td><td>" + uName + "</td>"  ;
        result += "<td>" + start + "</td><td>" + end + "</td>" ;
        if(isControllable == true){
            if(isPaid.compareToIgnoreCase("No") == 0)
            result += "<td><form> <input id='reservationIDToPay' type='hidden' value=" + rID + ">"
                    + "<input type='button' value='Confirm payment' class='btn form-btn btn-purple' onclick='sendajaxConfirmPayment(" + rID + ")'></form>" + "</td>";
            else{
                result += "<td></td>" ;
            }
            result += "<td><form> <input id='reservationIDToCancel' type='hidden' value=" + rID + ">"
                    + "<input type='button' value='Cancel' class='btn form-btn btn-purple' onclick='sendajaxCancelReservation(" + rID + ")'></form>" + "</td>";
        }
        else{
            result += "<td>"+ isPaid + "</td>" ;
        }
        
        
        return result ;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /*
            It's assumed that current reservations = the ones that aren't finished (checked out) yet, whether started or not
            */
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            String view = request.getParameter("view");
            if(view.compareToIgnoreCase("current") == 0){
                out.print(getCuurentReservations(hotelID));
            }
            else if (view.compareToIgnoreCase("specific") == 0){
                String from = request.getParameter("from"), to = request.getParameter("to");
                out.print(getSpecificReservations(hotelID, from , to));
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
