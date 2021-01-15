
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

@WebServlet(urlPatterns = {"/processNotifications"})
public class processNotifications extends HttpServlet {
    private String fetchNotifications(int hotelID)throws IOException, SQLException, ClassNotFoundException{
        String result = "" ;
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT * FROM notification WHERE hotelID = ? ORDER BY id DESC ";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setInt(1, hotelID);
        ResultSet RS = statement.executeQuery();
        boolean empty = true ;
        while (RS.next()) {
            empty = false ;
            String content = RS.getString("content") ;
            boolean isRead = RS.getBoolean("isRead");
            String timestamp = String.valueOf(RS.getTimestamp("createdAt"));
            result += makeNotification(isRead, content, timestamp) ;
            
        }
        if(empty)   {
            result = "<h3 style='color:white;'>Sorry, no notifications yet</h3>" ;        
        }
        else{
            line = "UPDATE notification SET isRead = 1 WHERE hotelID = ?" ;
            statement = Con.prepareStatement(line);
            statement.setInt(1, hotelID);
            statement.executeUpdate();
        }
        Con.close();
        return result ;
    }
    
    private String makeNotification(boolean isRead, String content, String time){
        String isNew = "" ;
        if(isRead == false){
            isNew = "** NEW **" ;
        }
        String notification = "<label class='notification'>" + isNew + "(" + time + ") - " + content + "</label>" ;
        notification += "<br><p style='color:white;'>----------------------------------------------------------------------"
                + "------------------------------------------------------------------------------</p><br>" ;
        return notification ;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            String output = fetchNotifications(hotelID);
            out.println(output);
            
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processNotifications.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processNotifications.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(processNotifications.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(processNotifications.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
