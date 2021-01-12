
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
                + " AVG(room.price) AS exPrice, AVG (review.rate) AS RATE, hotel.name AS HotelName, hotel.stars AS HotelStars "
                + "FROM hotel INNER JOIN room "
                + " ON hotel.id = room.hotelID AND hotel.cityID IN (SELECT city.id FROM city WHERE LOWER(city.name) LIKE ?) "
                + " LEFT JOIN review ON review.hotelID = hotel.id GROUP BY (hotel.id)";
        PreparedStatement statement = Con.prepareStatement(line);
        //statement.setString(1, checkIn);
        statement.setString(1, city);
        //statement.setString(3, _rooms + "");
        
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        while (RS.next()) {
            empty = false ;
            int id = RS.getInt("HotelID") ;
            String name = RS.getString("HotelName") ;
            int exPrice = (int)Math.ceil(RS.getDouble("exPrice"));
            int stars = RS.getInt("HotelStars");
            double rate = RS.getDouble("RATE");
            output += makeDiv(id, name, exPrice, rate, stars) ;
        }
        if(empty)   {
            output = "<h3>Sorry, no result matches your search</h3>" ;        
        }
        Con.close();
        return output;
    }
    
    private String makeDiv(int hotelID, String hotelName, int exPrice, double rate, int stars){
        String div = "<div><h3>" + hotelName + "  -  " + exPrice +  " $ per night" + 
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + " Rate : " + rate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  " + stars + " STARS</h3><br>" ;
        div += "<form class='form Log-form' action='viewHotel'><input name = 'hotelID' type='hidden' value=" + hotelID + ">" ;
        div += "<img id ='si' src = 'img/h" + hotelID + ".jpg'>" ;
        div += "<br><br><input type='submit' value='View Hotel' class='btn form-btn btn-purple'>" ;
        div += "</form></div><br><br><br>" ;
        return div ;
    }
    
    private String getFilteringForm(String city, int rooms, String checkInDate, String checkOutDate){
        String form = "<form class='form Log-form'  action='processFilteredSearch'>" +
                "<h3 style='color:white;'>Filter search results using : </h3><br><br>";
        form += "<input type='radio' id='price' name='options' value='price'> " 
        + "<label for='price'>Price</label><br><br>" + 
        "<input type='radio' id='stars' name='options' value='stars'> " 
        + "<label for='stars'>Hotel Stars</label><br><br>" + 
        "<input type='radio' id='rate' name='options' value='rate'> " +
                "<label for='meals'>Rating</label><br><br>" + 
                "<input type='radio' id='meals' name='options' value='meals'> " +
                "<label for='distance'>Including meals</label><br><br>" + 
                "<input type='radio' id='distance' name='options' value='distance'> " 
        + "<label for='rate'>Distance from city center</label><br><br>" ;
        form += "<input  class='input' type = 'number' name = 'val' > " ;
        form += "<input type = 'hidden' name = 'city' value = " + city + " > " ;
        form += "<input type = 'hidden' name = 'rooms' value = " + rooms + " > " ;
        form += "<input type = 'hidden' name = 'checkInDate' value = " + checkInDate + " > " ;
        form += "<input type = 'hidden' name = 'checkOutDate' value = " + checkOutDate + " > " ;
        form += "<input type='submit' value = 'Go' class='btn form-btn btn-purple'></form><br><br><br><br><br>" ;
        return form ;
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
            HttpSession session = request.getSession(true);
            session.setAttribute("checkIn", checkInDate);
            session.setAttribute("checkOut", checkOutDate);
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
            out.println(getFilteringForm(city, rooms, checkInDate, checkOutDate));

                
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
