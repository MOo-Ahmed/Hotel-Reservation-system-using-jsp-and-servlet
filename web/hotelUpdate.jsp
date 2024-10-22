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
        <script>
            function validateUpdateHotelForm() {
                var stars = document.getElementById("stars").value;
                var distance = document.getElementById("distance").value;
                var meals = document.getElementById("meals").value;
                var contacts = document.getElementById("contacts").value;
                var img = document.getElementById("img").value;
                if ((contacts == null || contacts == "" || contacts.trim() === '')
                        && (stars == null || stars == "" || stars.isNaN() == true)
                        && (meals == null || meals == "" || meals.trim() === '')
                        && (distance == null || distance == "" || distance.isNaN() == true)
                        && (img.length == 0)) {
                    document.getElementById("show_response").innerHTML = "Change at least 1 field !";
                    return false;
                } else if (img.length !== 0) {
                    var extension = img.toString().substring(img.toString().lastIndexOf(".")).toLocaleLowerCase();
                    if (extension !== ".jpg" && extension !== ".png" && extension !== ".jpeg") {
                        document.getElementById("show_response").innerHTML = "Invalid file type ! (use jpg/png/jpeg)";
                        return false;
                    }
                }
                return true;
            }
        </script>
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
                <h1 class="heading" align="center">Update hotel information </h1><br><br>
                <form action="processUpdateHotel" class="form Log-form" method="post" enctype="multipart/form-data" 
                      onsubmit="return validateUpdateHotelForm()">
                    <br>
                    <label>id: <%= hotelID%></label><br>
                    <label>name: <%= name%></label><br>
                    <label>city: <%= city%></label><br>
                    <label>country: <%= country%></label><br><br>
                    <input name = 'hotelID' type='hidden' value="<%= hotelID%>">
                    <div class="input-group">
                        <label>stars </label>
                        <input id="stars" name="stars" type="number" class="input" placeholder="<%= stars%>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>distance from city center </label>
                        <input id="distance" name="DFCC" type="number" class="input" placeholder="<%= DFCC%>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>including meals </label>
                        <input id="meals" name="meals" type="text" class="input" placeholder="<%= meals%>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>contacts </label>
                        <input id="contacts" name="contacts" type="text" class="input" placeholder="<%= contacts%>">
                        <span class="bar"></span>
                    </div>
                    <label>Upload new hotel photo</label><br>
                    <input id="img" type="file" name="hotelImg" style="color: white" /><br>
                    <input type="submit" value = "Update" class="btn form-btn btn-purple">
                    <br><br>
                    <label id="show_response"></label>
                </form>
                <form action="updateRooms.jsp" class="form Log-form">
                    <input type="hidden" name="hotelID" value = "<%=hotelID%>">
                    <input type="submit" value = "Update rooms" class="btn form-btn btn-purple">
                </form>
                <a href="hotelHome.jsp?hotelID=<%=hotelID%>" class="btn form-btn btn-purple">back to hotel home
                    <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                </a>
            </div>
        </main>
    </body>
</html>
