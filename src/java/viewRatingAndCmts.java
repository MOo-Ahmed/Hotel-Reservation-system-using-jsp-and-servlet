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

/**
 *
 * @author Kareem_Eltemsah
 */
@WebServlet(urlPatterns = {"/viewRatingAndCmts"})
public class viewRatingAndCmts extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String hotelID = request.getParameter("hotelID");
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "SELECT review.id as id, user.name as user, "
                    + "review.comment as comment, review.rate as rate "
                    + "from review inner join user on review.userID = user.id "
                    + "where review.hotelID = ?";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setString(1, hotelID + "");
            ResultSet RS = statement.executeQuery();
            String output = "";
            while (RS.next()) {
                output += "<li>"
                    + "<span class = 'paragraph'>" + RS.getString("user") + ":<br></span>"
                    + "<span class = 'paragraph'>" + RS.getString("comment") + "</span>"
                    + "<span class = 'paragraph'>" + RS.getInt("rate") + "</span>"
                    + "</li><br>";
            }
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>users search result</title>");
            out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css'>");
            out.println("<link rel='stylesheet' href='styles.css'>");        
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            out.println("<section class='Log'>");
            out.println("<div class='container'>");
            
            out.println("<div class='booking'>"
                    + "<br>"
                    + "<h3 class='main-heading'>Ratings and comments</h3>"
                    + "<br><br>"
                    + "<UL>" 
                    + output
                    + "</UL>"
                    + "</div>");
            
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(viewRatingAndCmts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(viewRatingAndCmts.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(viewRatingAndCmts.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(viewRatingAndCmts.class.getName()).log(Level.SEVERE, null, ex);
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
