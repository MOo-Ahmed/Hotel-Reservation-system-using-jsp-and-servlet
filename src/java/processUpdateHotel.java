/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Kareem_Eltemsah
 */
@WebServlet(urlPatterns = {"/processUpdateHotel"})
@MultipartConfig
public class processUpdateHotel extends HttpServlet {

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
            String stars = request.getParameter("stars");
            String DFCC = request.getParameter("DFCC");
            String meals = request.getParameter("meals");
            String contacts = request.getParameter("contacts");

            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "";
            PreparedStatement statement;
            if (!stars.equals("")) {
                line = "update hotel set stars=" + stars + " where id=" + hotelID;
                statement = Con.prepareStatement(line);
                int row = statement.executeUpdate();
            }
            if (!DFCC.equals("")) {
                line = "update hotel set distanceFromCC=" + DFCC + " where id=" + hotelID;
                statement = Con.prepareStatement(line);
                int row = statement.executeUpdate();
            }
            if (!meals.equals("")) {
                line = "update hotel set includingMeals='" + meals + "' where id=" + hotelID;
                statement = Con.prepareStatement(line);
                int row = statement.executeUpdate();
            }
            if (!contacts.equals("")) {
                line = "update hotel set Contacts='" + contacts + "' where id=" + hotelID;
                statement = Con.prepareStatement(line);
                int row = statement.executeUpdate();
            }
            
            Part filePart = request.getPart("hotelImg");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName.endsWith(".jpg") || fileName.endsWith(".png")) {
                line = "select imgCount from hotel where id = " + hotelID + ";";
                statement = Con.prepareStatement(line);
                ResultSet rs = statement.executeQuery();
                rs.next();
                InputStream fileContent = filePart.getInputStream();
                Random random = new Random();
                File img = new File("C:\\Users\\Kareem Eltemsah\\Documents\\GitHub\\Hotel-Reservation-system-using-jsp-and-servlet\\web\\img",
                        "H" + hotelID + "_" + (rs.getInt("imgCount")+1) + ".jpg");
                
                line = "update hotel set imgCount = imgCount + 1 where id = " + hotelID + ";";
                statement = Con.prepareStatement(line);
                statement.executeUpdate();
                Files.copy(fileContent, img.toPath());
            }
            response.sendRedirect("hotelHome.jsp?hotelID=" + hotelID);
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
            Logger.getLogger(processUpdateHotel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateHotel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(processUpdateHotel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(processUpdateHotel.class.getName()).log(Level.SEVERE, null, ex);
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
