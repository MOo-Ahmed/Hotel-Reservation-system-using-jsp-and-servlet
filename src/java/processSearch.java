
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

@WebServlet(urlPatterns = {"/processSearch"})
public class processSearch extends HttpServlet {

    private String getAllHotels(int _rooms, int _adults, int _children, String checkIn, String checkOut, String city) 
            throws IOException, SQLException, ClassNotFoundException{
        city = city.toLowerCase();
        String output = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT DISTINCT (hotel.id) AS HotelID, COUNT(hotel.id) AS RoomsCount , "
                + " AVG(Q2.price) AS exPrice,AVG (review.rate) AS RATE, hotel.name AS HotelName "
                + "FROM hotel INNER JOIN (SELECT * FROM room WHERE room.id IN "
                + "(SELECT roomreservation.roomID AS roomID FROM roomreservation INNER JOIN reservation ON roomreservation.reservationID = reservation.id AND reservation.endDate <= ?)) AS Q2 "
                + " ON hotel.id = Q2.HotelID AND hotel.cityID IN (SELECT city.id FROM city WHERE LOWER(city.name) LIKE ?) "
                + " INNER JOIN review ON review.hotelID = hotel.id GROUP BY (hotel.id) HAVING RoomsCount >= ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, checkIn);
        statement.setString(2, city);
        statement.setString(3, _rooms + "");
        
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        while (RS.next()) {
            empty = false ;
            int id = RS.getInt("HotelID") ;
            String name = RS.getString("HotelName") ;
            int exPrice = (int)Math.ceil(RS.getDouble("exPrice"));
            double rate = RS.getDouble("RATE");
            output += makeDiv(id, name, exPrice, rate) ;
        }
        if(empty)   output = "empty";
        Con.close();
        return output;
    }
    
    private String makeDiv(int hotelID, String hotelName, int exPrice, double rate){
        String div = "<div><h3>" + hotelName + "  -  " + exPrice +  " Pounds per night" + 
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + " Rate : " + rate + "</h3><br>" ;
        div += "<form class='form Log-form' action='viewHotel.jsp'><input name = 'hotelID' type='hidden' value=" + hotelID + ">" ;
        div += "<img id ='si' class = 'searchImage' src = 'img/h" + hotelID + ".jpg'>" ;
        div += "<br><br><input type='submit' value='View Hotel' class='btn form-btn btn-purple'>" ;
        div += "</form></div><br><br><br>" ;
        return div ;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /*
             1. In the previous page, the user entered the num of rooms, adults and children, the dates of check in and out 
             2. Get all hotels having number of rooms >= rooms required as long as these rooms are not
             reserved in the interval he entered and can accomodate children if any
             3. Return a result set array / JSON
             4. Loop through the result set and add a div for each hotel
            
             */
            String city = request.getParameter("city");
            int rooms = Integer.parseInt(request.getParameter("rooms"));
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));
            String r = getAllHotels(rooms, adults, children, checkInDate, checkOutDate, city);
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Search results</title>");
            out.println("<link rel='stylesheet' href='styles.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            
            out.println("<section class='Log'>");
            out.println("<div class='container'>");
                
            out.println(r);
            out.println("</div>");
            out.println("</section>");
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processSearch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processSearch.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processSearch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processSearch.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
