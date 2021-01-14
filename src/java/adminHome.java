
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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

    private String getAllHotels(String AdminID)
            throws IOException, SQLException, ClassNotFoundException {
        String output = "";
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT hotelAdmin.hotelID AS HotelID, hotel.name AS HotelName FROM hotelAdmin INNER JOIN hotel "
                + "ON hotel.id = hotelAdmin.hotelID AND adminID = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, AdminID);

        ResultSet RS = statement.executeQuery();
        boolean empty = true;
        while (RS.next()) {
            empty = false;
            int id = RS.getInt("HotelID");
            String name = RS.getString("HotelName");

            output += makeDiv(id, name);
        }
        if (empty) {
            output = "<h3>Sorry, no hotels under your admistration</h3>";
        }
        Con.close();
        return output;
    }

    private String makeDiv(int hotelID, String hotelName) {
        String div = "<form class='form Log-form' action='hotelHome.jsp'><input name = 'hotelID' type='hidden' value=" + hotelID + ">";
        div += "<label>" + hotelName + "</label>";
        div += "<br><br><input type='submit' value='Proceed to Hotel' class='btn form-btn btn-purple'>";
        div += "</form><br><br><br>";
        return div;
    }

    private ArrayList<String> getAdminInfo(String AdminID)
            throws IOException, SQLException, ClassNotFoundException {
        //Returns : name,username,password,email,phone
        ArrayList<String> info = new ArrayList<>();
        String output = "";
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT * FROM user WHERE user.id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, AdminID);

        ResultSet RS = statement.executeQuery();
        boolean empty = true;
        while (RS.next()) {
            empty = false;
            info.add(RS.getString("name"));
            info.add(RS.getString("username"));
            info.add(RS.getString("password"));
            info.add(RS.getString("email"));
            info.add(RS.getString("phoneNumber"));
            
        }

        Con.close();
        return info;
    }

    private String getUserInfoUpdateForm(String userID, String username , String  name, String  Password , String  phone, String email){
        String output = "<br><br><br><br> "
                + "<h5 class='section-head'>"
                + "<span class='heading'>View & Update your personal info</span>"
                + "<span class='sub-heading'>Not allowed to change the username</span></h5>"
                + "<div class='Log-content'>"
                + "<form action='processUpdateUserInfo' id='personalInfoForm' method='POST' class='form Log-form'>"
                + "<label>Username : " + username + " (Unchangeable)</label><br><br>"
                + "<input id='source' class='input' type = 'hidden' name='source' value='admin'>"
                + "<input name='id' id='id' class='input' type = 'hidden' value=" + userID +">"
                + "<label>Name : </label> <input id='name' class='input' type = 'text' name= 'name' value = '" + name + "'>"
                + "<label>Password : </label><input id='password' class='input' type = 'text' name='password' placeholder = " + Password + " value = " + Password + " required>"
                + "<label>Phone : </label><input id='phone' class='input' type = 'number' name='phone' placeholder = " + phone + " value = " + phone + " required>"
                + "<label>Email : </label><input id='email' class='input' type = 'email' name='email' placeholder = '" + email + "' value = '" + email + "' required>"
                + "<input id='submitChangeInfo' type='submit' value = 'Update my info' "
                + "class='btn form-btn btn-purple'>"
                + "<br><br><br>"
              
                + "</form>"
                + " </div>" ;
        return output ;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true)  ;
            if (session.getAttribute("adminID") == null || session.getAttribute("adminID").toString().equals("")) {
                response.sendRedirect("Login.jsp");
            }
            
            //session = request.getSession(true);
            String adminID = session.getAttribute("adminID").toString();
            ArrayList<String> info = getAdminInfo(adminID);
            
            String r = getAllHotels(adminID);
            String name = info.get(0);
            String username = info.get(1);
            String Password = info.get(2);
            String email = info.get(3);
            String phone = info.get(4);
            
            String form = getUserInfoUpdateForm(adminID, username, name, Password, phone, email) ;
            

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Manage hotels</title>");
            out.println("<link rel='stylesheet' href='styles.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            //out.println("<p>" + adminID +"<p>");

            out.println("<section class='Log'>");
            out.println("<div class='container'>");

            out.println("<h1>" + username + "</h1>");
            out.println("<a href='signOut' class='btn form-btn btn-purple'>Logout "
                    + "<span class='dots'><i class='fas fa-ellipsis-h'></i></span></a><br><br><br>");

            out.println(r);
            out.println(form);
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
