/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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

/**
 *
 * @author Kareem_Eltemsah
 */
@WebServlet(urlPatterns = {"/viewHotel"})
public class viewHotel extends HttpServlet {

    String getHotelData (String hotelID, String checkIn, HttpSession session) throws SQLException, ClassNotFoundException {
        //retreiving hotel data
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT hotel.id as id, hotel.name as name, "
                    + "city.name as city, country.name as country "
                    + "FROM hotel INNER JOIN city "
                    + "ON hotel.cityID = city.id "
                    + "INNER JOIN country "
                    + "ON city.countryID = country.id "
                    + "WHERE hotel.id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, hotelID + "");
        ResultSet RS = statement.executeQuery();
        String hotelData = "";
        if (RS.next()) {
            String hotelName = RS.getString("name");
            String city = RS.getString("city");
            String country = RS.getString("country");
            //String lat = String.valueOf(RS.getDouble("latitude"));
            //String lng = String.valueOf(RS.getDouble("longitude"));
            session.setAttribute("hotelName", hotelName);
            hotelData = "<div class='booking'>"
                    + "<h1 align='center' class='heading' style=\"color:white ;\">" + hotelName + "</h1>"
                    + "<h3 align='center' class='sub-heading'>" + city + ", " + country + "</h3>"
                    + "<div class='MagicScroll' data-options='height: 500; mode: carousel; draggable: true;'> "
                    + "<img class = 'featured-hotels' src = 'img/H" + hotelID + "_1.jpg'>"
                    + "<img class = 'featured-hotels' src = 'img/H" + hotelID + "_2.jpg'>"
                    + "<img class = 'featured-hotels' src = 'img/H" + hotelID + "_3.jpg'>"
                    + "</div>"
                    + "<div id='googleMap' style='width:400px;height:400px;'></div>"
                    + "<script>"
                    + "function initMap() {\n"
                    + "var location= {lat: 0, lng: 0};\n"
                    + "var map = new google.maps.Map(document.getElementById('googleMap'),{zoom: 4, center: location});\n"
                    + "var marker = new google.maps.Marker({position: location, map: googleMap});\n"
                    + "}"
                    + "</script>"
                    + "<script src='https://maps.googleapis.com/maps/api/js?key=AIzaSyB4F9aEvkmbzdyUiWIFN7BR5Yr7RKAobqw&callback=initMap'></script>"
                    + "<br"
                    + "</div>";
        }
        //retrieving all the available rooms
        line = "SELECT room.id as id, room.name as name, "
                + "roomtype.name as roomType, price, facilities "
                + "FROM room inner join roomtype on room.roomTypeID = roomtype.id "
                + "where room.id not in (SELECT roomreservation.roomID as id "
                + "from roomreservation inner join reservation "
                + "on roomreservation.reservationID = reservation.id "
                + "where reservation.endDate > ?) and room.hotelID = ?";
        statement = Con.prepareStatement(line);
        statement.setString(1, checkIn + "");
        statement.setString(2, hotelID + "");
        RS = statement.executeQuery();
        int roomsCounter = 0;
        String roomsData = "";
        while (RS.next()) {
            roomsCounter++;
            int roomID = RS.getInt("id");
            roomsData += "<li>"
                + "<img class = 'room-image' src = 'img/H" + hotelID + "_R" + ((roomsCounter%5)+1) + ".jpg'>"
                + "<span class = 'room-price' style=\"color:white ;\">" + RS.getString("name") + "</span>"
                + "<span class = 'room-price' style=\"color:white ;\">Type: " + RS.getString("roomType") + "</span>"
                + "<span class = 'room-price' style=\"color:white ;\">Price: " + RS.getInt("price") + "$ per night</span>"
                + "<span style=\"color:white ;\">Facilities:<br>" + RS.getString("facilities") + "</span>"
                + "<br><br>"
                + "<span style=\"color:white ;\">"
                + "<input name = 'names' type='checkbox' value='" + roomID + "' class = 'rooms-btn'>"
                + " Reserve room</span>"
                + "<br><br>"
                + "</li>"; 
        }
        roomsData = "<div class = 'rooms'>"
                + "<form action='makeReservation' class='form Log-form'>"
                + "<h3 class='main-heading'>" + roomsCounter + " rooms available on " + checkIn + "</h3>"
                + "<br><br>"
                + "<UL>"
                + roomsData
                + "</UL>"
                + "<input type='submit' value ='reserve checked rooms' class='btn form-btn btn-purple'>"
                + "</form>"
                + "</div>";
        //retrieving all the hotel reviews
        line = "SELECT review.id as id, user.name as user, "
                + "review.comment as comment, review.rate as rate "
                + "from review inner join user on review.userID = user.id "
                + "where review.hotelID = ?";
        statement = Con.prepareStatement(line);
        statement.setString(1, hotelID + "");
        RS = statement.executeQuery();
        int reviewsCounter = 0;
        float rating = 0;
        String reviewsData = "";
        while (RS.next()) {
            reviewsCounter++;
            rating += RS.getInt("rate");
            int reviewID = RS.getInt("id");
            reviewsData += "<tr><td style=\"color:white ;\"><span >" + RS.getString("user") + ":<br></span>"
                    + "<span >" + RS.getString("comment") + "</span></td>"
                    + "<td style=\"color:white ;\"><span >" + RS.getInt("rate") + "</span></td>"
                    + "</tr>"; 
        }
        rating = rating / reviewsCounter;
        String temp = "<div class='Log-content'>"
                + "<form action='makeReview' class='form Log-form'>"
                + "<span class='heading' style=\"color:white ;\">User Rating</span>";
        for (int i=1 ; i<=5 ; i++) {
            if (i <= Math.ceil(rating))
                temp += "<span class='fa fa-star checked rating'></span>";
            else 
                temp += "<span class='fa fa-star' style=\"color:grey ;\"></span>";
        }
        reviewsData = temp 
                + "<p style=\"color:white ;\">" + rating + " average based on " + reviewsCounter + " reviews.</p>"
                + "<div class='input-group'>"
                + "<input id='comment' name='comment' type='text' class='input' placeholder='comment' required>"
                + "<span class='bar'></span>"
                + "<label for='rating'>Rating: </label>"
                + "<input id='rate' name='rate' type='range' min='1' max='5' step='1' required><br>"
                + "<input id='submitreview' type='submit' value = 'Post review' class='btn form-btn btn-purple'>"
                + "</div>"
                + "<h5 style=\"color:white ;\">reviews(" + reviewsCounter + ")</h5>"
                + "<table class=\"center\" width=80% cellspacing=15>"
                + reviewsData
                + "</table>"
                + "</form>"
                + "</div>";
        
        Con.close();
        statement.close();
        RS.close();
        return hotelData + roomsData + reviewsData;
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(true);
            String checkIn = session.getAttribute("checkIn").toString();
            String hotelID = request.getParameter("hotelID");
            session.setAttribute("hotelID", hotelID);
            String output = getHotelData(hotelID, checkIn, session);
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Hotel Details</title>");
            out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css'>");
            out.println("<link rel='stylesheet' href='styles.css'>");
            out.println("<link type='text/css' rel='stylesheet' href='magicscroll/magicscroll.css'/>");
            out.println("<script type='text/javascript' src='magicscroll/magicscroll.js'></script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            out.println("<section class='Log'>");
            out.println("<div class='container'>");
            out.println(output);
            out.println("</div>");
            out.println("</section>");
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(viewHotel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(viewHotel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(viewHotel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(viewHotel.class.getName()).log(Level.SEVERE, null, ex);
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
