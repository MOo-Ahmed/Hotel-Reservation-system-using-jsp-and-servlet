
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

@WebServlet(urlPatterns = {"/processUpdateReservation"})
public class processUpdateReservation extends HttpServlet {

    private String getRoomsAvailableForUpdate(HttpSession session, HttpServletRequest request, int resID, String checkIn, String checkOut)
            throws IOException, SQLException, ClassNotFoundException {

        /*
         Select all rooms that are not occupied in reservations (having end date > checkIn OR start date < checkOut)
         Then -> show these rooms to the user to choose from
         If he chooses some rooms, first cancel the old reservation, create new one
        
         */
        
        
        String output = "";
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        
        // Get hotel info
        String line = "SELECT hotel.name AS HotelName, reservation.hotelID AS HotelID FROM reservation INNER JOIN hotel ON "
                + "hotel.id = reservation.hotelID AND reservation.id = ?" ;
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, resID);
        ResultSet RS = statement.executeQuery();  
        RS.next();
        int hotelID = RS.getInt("HotelID");
        String hotelName = RS.getString("HotelName");
        
        //Delete the current reservation
        line = "DELETE FROM roomreservation WHERE reservationID = ?" ;
        statement = Con.prepareStatement(line);
        statement.setInt(1, resID);
        statement.executeUpdate();
        line = "DELETE FROM reservation WHERE id = ?" ;
        statement = Con.prepareStatement(line);
        statement.setInt(1, resID);
        statement.executeUpdate();
        
        line = "SELECT room.id AS RoomID, room.name AS RoomName, room.price AS RoomPrice, room.facilities AS Facilities, room.hotelID AS HotelID"
                + " FROM room WHERE room.hotelID = ? AND room.id NOT IN "
                + " (SELECT roomreservation.roomID FROM roomreservation INNER JOIN reservation ON reservation.id = roomreservation.reservationID "
                + " AND reservation.endDate > ? OR reservation.startDate < ? ) ";
        statement = Con.prepareStatement(line);
        statement.setInt(1, hotelID);
        statement.setString(2, checkIn);
        statement.setString(3, checkOut);
        RS = statement.executeQuery();  
        boolean empty = true;
        while (RS.next()) {
            empty = false;
            int id = RS.getInt("RoomID");
            String name = RS.getString("RoomName");
            String facilities = RS.getString("Facilities");
            int price = (int) RS.getDouble("RoomPrice");

            output += makeRoomList(id, name, facilities, price, hotelID);
        }
        if (empty) {
            output = "<label>Sorry, no rooms available during the entered period</label>";
        } else {
            output = "<h3 class='main-heading'> These rooms are available </h3>"
                    + "<br><br>"
                    + " <table><tr><th>Rerserve</th><th>Room Name</th><th>Price</th><th>Facilities</th></tr>"
                    + output
                    + "</table>"
                    + "<input type='button' value ='Reserve selected rooms' class='btn form-btn btn-purple'  onclick='processNewReservation()'>"
                    + "<br><br><label>Note : This will discard your original reservation</label>";
            
            session.setAttribute("hotelID" , hotelID);
            session.setAttribute("checkIn" , checkIn);
            session.setAttribute("checkOut" , checkOut);
            session.setAttribute("hotelName" , hotelName);

        }
        Con.close();
        return output;
    }

    private String makeRoomList(int id, String name, String facilities, int price, int hotelID) {
        String result = "<tr>"+ "<td><input name = 'names' type='checkbox' value='" + id + "' class = 'rooms-btn'></td>";
        result += "<td>" + name + "</td><td>" + price + "</td>";
        result += "<td>" + facilities + "</td>"
                + "<td><input name = 'hotelID' type='hidden' value='" + hotelID + "' ></td></tr>";
        return result;

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            int resID = Integer.parseInt(request.getParameter("reservationID"));
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            out.print(getRoomsAvailableForUpdate(session, request, resID, start, end));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processUpdateReservation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processUpdateReservation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
