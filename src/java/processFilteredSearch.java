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


@WebServlet(urlPatterns = {"/processFilteredSearch"})
public class processFilteredSearch extends HttpServlet {

    private String getAllHotels(String opName, int opValue ,  int _rooms, int _adults, int _children, String checkIn, String checkOut, String city) 
            throws IOException, SQLException, ClassNotFoundException{
        city = city.toLowerCase();
        String output = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String filterCondition = "" ;
        if(opName.compareTo("price") == 0){
            filterCondition = " HAVING exPrice <=" ;
        }
        else if(opName.compareTo("rate") == 0){
            filterCondition = " HAVING RATE >=" ;
        }
        else if(opName.compareTo("stars") == 0){
            filterCondition = " HAVING HotelStars >=" ;
        }
        else if(opName.compareTo("distance") == 0){
            filterCondition = " HAVING Dist <=" ;
        }
        else if(opName.compareTo("meals") == 0){
            filterCondition = " HAVING Meals = " ;
        }
        // For each case you may eant to make a separate query line
        String line = "SELECT DISTINCT (hotel.id) AS HotelID, COUNT(hotel.id) AS RoomsCount , hotel.distanceFromCC AS Dist, hotel.includingMeals AS Meals,"
                + " AVG(room.price) AS exPrice, AVG (review.rate) AS RATE, hotel.name AS HotelName, hotel.stars AS HotelStars "
                + "FROM hotel INNER JOIN room "
                + " ON hotel.id = room.hotelID AND hotel.cityID IN (SELECT city.id FROM city WHERE LOWER(city.name) LIKE ?) "
                + " INNER JOIN review ON review.hotelID = hotel.id GROUP BY (hotel.id) " + filterCondition + " ?";
        
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, city);
        if(opName.compareTo("meals") == 0)   
                statement.setString(2, "Yes");
        else    statement.setString(2, opValue + ""); 
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        while (RS.next()) {
            empty = false ;
            int id = RS.getInt("HotelID") ;
            String name = RS.getString("HotelName") ;
            int exPrice = (int)Math.ceil(RS.getDouble("exPrice"));
            double rate = RS.getDouble("RATE");
            int stars = RS.getInt("HotelStars") ;
            double distance = RS.getDouble("Dist");
            String meals = RS.getString("Meals");
            if(meals.compareTo("Yes") == 0) meals = "Including meals" ;
            output += makeDiv(id, name, exPrice, rate, stars, distance, meals) ;
        }
        if(empty)   {
            output = "<h3>Sorry, no result matches your search</h3>" ;        
        }
        Con.close();
        return output;
    }
    
    private String makeDiv(int hotelID, String hotelName, int exPrice, double rate, int stars, double distance, String meals){
        String div = "<div><h3>" + hotelName + "  -  " + exPrice +  " Pounds per night" + 
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + " Rate : " + rate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  " + stars + " STARS" +
                "&nbsp;&nbsp;&nbsp;" + distance + " KM from city center" + "&nbsp;&nbsp;&nbsp; - " + meals + "</h3><br>" ;
        div += "<form class='form Log-form' action='HotelProfile.jsp'><input name = 'hotelID' type='hidden' value=" + hotelID + ">" ;
        div += "<img id ='si' src = 'img/h" + hotelID + ".jpg'>" ;
        div += "<br><br><input type='submit' value='View Hotel' class='btn form-btn btn-purple'>" ;
        div += "</form></div><br><br><br>" ;
        return div ;
    }


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String optionName = request.getParameter("options");
            int optionValue = 0;
            if(optionName.compareTo("meals") != 0)      optionValue = Integer.parseInt(request.getParameter("val"));
            String city = request.getParameter("city");
            int rooms = Integer.parseInt(request.getParameter("rooms"));
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            int adults = 0;
            int children = 0;
            
            String r = getAllHotels(optionName, optionValue , rooms, adults, children, checkInDate, checkOutDate, city);
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Filteration results </title>");
            out.println("<link rel='stylesheet' href='styles.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            out.println("<br><br><a href='customerHome.jsp' class='btn form-btn btn-purple'>Back To Search page</a>");
            
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
            Logger.getLogger(processFilteredSearch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processFilteredSearch.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(processFilteredSearch.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processFilteredSearch.class.getName()).log(Level.SEVERE, null, ex);
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
