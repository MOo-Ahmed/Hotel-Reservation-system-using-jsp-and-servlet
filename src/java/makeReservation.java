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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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
@WebServlet(urlPatterns = {"/makeReservation"})
public class makeReservation extends HttpServlet {

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
            List roomsIDs = Arrays.asList(request.getParameterValues("names"));
            HttpSession session = request.getSession(true);
            String userID = session.getAttribute("userID").toString();
            String hotelID = session.getAttribute("hotelID").toString();
            String checkIn = session.getAttribute("checkIn").toString();
            String checkOut = session.getAttribute("checkOut").toString();
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            //inserting reservation record
            String line = "INSERT INTO reservation (userID, hotelID, startDate, endDate, isPaid) "
                    + "VALUES (? , ?, ? , ?, ?);";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setString(1, userID + "");
            statement.setString(2, hotelID + "");
            statement.setString(3, checkIn + "");
            statement.setString(4, checkOut + "");
            statement.setString(5, "No");
            statement.execute();
            //getting the id of the record we just
            line = "select id from reservation "
                    + "where userID=? and hotelID=? and startDate=? and endDate=? and isPaid=?";
            statement = Con.prepareStatement(line);
            statement.setString(1, userID + "");
            statement.setString(2, hotelID + "");
            statement.setString(3, checkIn + "");
            statement.setString(4, checkOut + "");
            statement.setString(5, "No");
            ResultSet RS = statement.executeQuery();
            
            int reservationID = 0;
            if (RS.next())
                reservationID = RS.getInt("id");
            //inserting rooms resevation record
            for (int i=0 ; i<roomsIDs.size() ; i++) {
                line = "INSERT INTO roomreservation (reservationID, roomID) "
                        + "VALUES ('" + reservationID + "' , '" + roomsIDs.get(i) + "');";
                statement = Con.prepareStatement(line);
                statement.execute();
            }
            
            //collecting data to print final resevation card
            List roomNames = new ArrayList();
            int totalPrice = 0;
            for (int i=0 ; i<roomsIDs.size() ; i++) {
                line = "select name, price from room where id = " + roomsIDs.get(i);
                statement = Con.prepareStatement(line);
                RS = statement.executeQuery();
                if (RS.next()) {
                    roomNames.add(RS.getString("name"));
                    totalPrice += RS.getInt("price");
                }
            }
            String output = "Hotel: " + session.getAttribute("hotelName") + "<br>"
                    + "Number of rooms: " + roomsIDs.size() + "<br>"
                    + "Rooms names: ";
            for (int i=0 ; i<roomNames.size()-1 ; i++)
                output += roomNames.get(i) + ", ";
            output += roomNames.get(roomNames.size()-1) + "<br>"
                    + "CheckIn date: " + checkIn + "<br>"
                    + "CheckOut date: " + checkOut + "<br>"
                    + "Total Price: " + (totalPrice);
                
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Reservation Done</title>"); 
            out.println("<link rel='stylesheet' href='styles.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<main>");
            out.println("<section class='Log'>");
            out.println("<div class='container'>");
            out.println("<h1 align='center' class='heading'>Reservation has bean made</h1>"
                    + "<p align='center' class='room-price'>" + output + "</P>"
                    + "<a href='customerHome.jsp' class='btn btn-gradient'>Go back to search page"
                    + "<span class='dots'><i class='fas fa-ellipsis-h'></i></span>"
                    + "</a>");
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
            Logger.getLogger(makeReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(makeReservation.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(makeReservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(makeReservation.class.getName()).log(Level.SEVERE, null, ex);
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
