import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/validateSignUp"})
public class validateSignUp extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "SELECT * FROM user WHERE username = ?";
            PreparedStatement statement = Con.prepareStatement(line);
            statement.setString(1, username + "");
            ResultSet RS = statement.executeQuery();
            
            if (RS.next()) {
                // Then we know this user info exists before
                Con.close();
                out.print("no");
            } else {
                String TempPassword = generatePassword(10);
                line = "INSERT INTO user (name, email, username, password) VALUES (? , ? , ?, ?)";
                statement = Con.prepareStatement(line);
                statement.setString(1, name + "");
                statement.setString(2, email + "");
                statement.setString(3, username + "");
                statement.setString(4, TempPassword);
                statement.executeUpdate();
                sendEmail(email, TempPassword);
                out.print("yes");
                Con.close();
            }
        }
    }

    private String generatePassword(int length) {
        String capitalCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String specialCharacters = "!@#$";
        String numbers = "1234567890";
        String combinedChars = capitalCaseLetters + lowerCaseLetters + specialCharacters + numbers;
        Random random = new Random();
        char[] password = new char[length];

        password[0] = lowerCaseLetters.charAt(random.nextInt(lowerCaseLetters.length()));
        password[1] = capitalCaseLetters.charAt(random.nextInt(capitalCaseLetters.length()));
        password[2] = specialCharacters.charAt(random.nextInt(specialCharacters.length()));
        password[3] = numbers.charAt(random.nextInt(numbers.length()));

        for (int i = 4; i < length; i++) {
            password[i] = combinedChars.charAt(random.nextInt(combinedChars.length()));
        }
        return String.valueOf(password);
    }

    private void sendEmail(String to, String password) {
        String from = "m.a3bdelnabi@gmail.com";

        // Assuming you are sending email from localhost
        String host = "localhost";
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        Session session = Session.getDefaultInstance(properties);

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(from));

            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            message.setSubject("Hotel Reservation system - temp password");

            message.setText("Here is your password : \n" + password + "\nUse it to sign in");

            // Send message
            Transport.send(message);
        } catch (MessagingException mex) {
            //mex.printStackTrace();
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(validateSignUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(validateSignUp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(validateSignUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(validateSignUp.class.getName()).log(Level.SEVERE, null, ex);
        }
}
    @Override
        public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
