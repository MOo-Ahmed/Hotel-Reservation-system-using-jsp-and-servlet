
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

@WebServlet(urlPatterns = {"/adminHome"})
public class adminHome extends HttpServlet {
    private String getAllHotels(int AdminID) 
            throws IOException, SQLException, ClassNotFoundException{
        String output = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT hotelAdmin.hotelID AS HotelID, hotel.name AS HotelName FROM hotelAdmin INNER JOIN hotel "
                + "ON hotel.id = hotelAdmin.hotelID AND adminID = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, AdminID);
        
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        while (RS.next()) {
            empty = false ;
            int id = RS.getInt("HotelID") ;
            String name = RS.getString("HotelName") ;
            
            output += makeDiv(id, name) ;
        }
        if(empty)   {
            output = "<h3>Sorry, no hotels under your admistration</h3>" ;        
        }
        Con.close();
        return output;
    }
    
    private String makeDiv(int hotelID, String hotelName){
        String div = "<form class='form Log-form' action='hotelHome.jsp'><input name = 'hotelID' type='hidden' value=" + hotelID + ">" ;
        div += "<label>" + hotelName + "</label>" ;
        div += "<br><br><input type='submit' value='Proceed to Hotel' class='btn form-btn btn-purple'>" ;
        div += "</form><br><br><br>" ;
        return div ;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int adminID = Integer.parseInt(request.getParameter("id")) ;
            HttpSession session = request.getSession(true);
            session.setAttribute("adminID", adminID);
            String r = getAllHotels(adminID);
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Manage hotels</title>");
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
            Logger.getLogger(adminHome.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(adminHome.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(adminHome.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(adminHome.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
