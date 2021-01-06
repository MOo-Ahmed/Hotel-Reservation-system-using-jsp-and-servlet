<%-- 
    Document   : hotelUpdate
    Created on : Jan 6, 2021, 5:24:03 AM
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
        <title>Hotel Update</title>
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
            String line = "SELECT hotel.id, hotel.name, stars, distanceFromCC, "
                    + "includingMeals, contacts, city.name as city, "
                    + "country.name as country FROM hotel inner join city "
                    + "on hotel.cityID=city.id inner join country "
                    + "on city.countryID=country.id WHERE hotel.id=" + hotelID + ";";
            PreparedStatement statement = Con.prepareStatement(line);
            ResultSet RS = statement.executeQuery();
            RS.next();
            String name = RS.getString("name");
            int stars = RS.getInt("stars");
            double DFCC = RS.getDouble("distanceFromCC");
            String meals = RS.getString("includingMeals");
            String city = RS.getString("city");
            String country = RS.getString("country");
            String contacts = RS.getString("contacts");
        %>
        <main>
            <div class="container">
                <br>
                <form action="processUpdateHotel" class="form Log-form">
                    <br>
                    <label>Update hotel information </label><br><br>
                    <label>id: <%= hotelID %></label><br>
                    <label>name: <%= name %></label><br>
                    <label>city: <%= city %></label><br>
                    <label>country: <%= country %></label><br><br>
                    <input name = 'hotelID' type='hidden' value="<%= hotelID %>">
                    <div class="input-group">
                        <label>stars </label>
                        <input name="stars" type="number" class="input" placeholder="<%= stars %>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>distance from city center </label>
                        <input name="DFCC" type="number" class="input" placeholder="<%= DFCC %>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>including meals </label>
                        <input name="meals" type="text" class="input" placeholder="<%= meals %>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>contacts </label>
                        <input name="contacts" type="text" class="input" placeholder="<%= contacts %>">
                        <span class="bar"></span>
                    </div>
                    <input type="submit" value = "Update" class="btn form-btn btn-purple">
                </form>
            </div>
        </main>
    </body>
</html>
