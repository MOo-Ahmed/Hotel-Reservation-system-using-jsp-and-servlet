<%-- 
    Document   : updateRooms
    Created on : Jan 12, 2021, 1:07:50 PM
    Author     : Kareem_Eltemsah
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rooms update</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <%
            String hotelID = request.getParameter("hotelID");
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "SELECT * FROM room where hotelID = " + hotelID;
            PreparedStatement statement = Con.prepareStatement(line);
            ResultSet RS = statement.executeQuery();%>
            <main>
            <div class="container">
                <br>
                <h1 class="heading" align="center">Update hotel rooms </h1><br><br>
                    
            <%while(RS.next()){
                int roomID = RS.getInt("id");
                String name = RS.getString("name");
                int roomTypeID = RS.getInt("roomTypeID");
                float price = RS.getFloat("price");
                String facilities = RS.getString("facilities");%>
                
                <form action="processUpdateRoom" class="form Log-form">
                <label>id: <%= roomID %></label><br>
                <label>hotel id: <%= hotelID %></label><br><br>
                <input name = 'hotelID' type='hidden' value="<%= hotelID %>">
                <input name = 'roomID' type='hidden' value="<%= roomID %>">
                <div class="input-group">
                    <label>name </label>
                    <input name="name" type="text" class="input" placeholder="<%= name %>">
                    <span class="bar"></span>
                </div>
                <div class="input-group">
                    <label>room type id </label>
                    <input name="roomTypeID" type="number" class="input" placeholder="<%= roomTypeID %>">
                    <span class="bar"></span>
                </div>
                <div class="input-group">
                    <label>price </label>
                    <input name="price" type="number" class="input" placeholder="<%= price %>">
                    <span class="bar"></span>
                </div>
                <div class="input-group">
                    <label>facilities </label>
                    <input name="facilities" type="text" class="input" placeholder="<%= facilities %>">
                    <span class="bar"></span>
                </div>
                <input type="submit" value = "Update" class="btn form-btn btn-purple">
                <br><br>
                </form>
                    
            <%}%>
        
                <form action="addRoom.jsp" class="form Log-form">
                    <input type="hidden" name="hotelID" value = "<%=hotelID%>">
                    <input type="submit" value = "add room" class="btn form-btn btn-purple">
                </form>
                <a href="hotelHome.jsp?hotelID=<%=hotelID%>" class="btn form-btn btn-purple">back to hotel home
                    <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                </a>
            </div>
        </main>
    </body>
</html>
