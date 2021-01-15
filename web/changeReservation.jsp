<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change reservation</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
        <script>
            function sendajaxUpdateReservation() {
                var reservationID = document.getElementById("resID").value;
                var start = document.getElementById("start").value;
                var end = document.getElementById("end").value;
                var operation = "check" ;
                
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processUpdateReservation", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&start=" + start + "&end=" + end + "&operation=" + operation);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        if (result.startsWith("<h3") == true) {
                            //window.location.replace("customerHome.jsp");
                            document.getElementById("show_response").innerHTML = result;
                        }
                        else if (result.startsWith("<label>") == true) {
                            document.getElementById("show_response").innerHTML = result;
                        }
                        else {
                            document.getElementById("show_response").innerHTML = "Something went wrong .. try again";
                        }
                    }
                }
            }
        
            function processNewReservation(){
                
                // Part rwo : insert new reservation
                var form = document.getElementById("updateForm");
                form.submit();
                
            }
            
            function cancelCurrentReservation(){
                // First part : delete the reservation
                var reservationID = document.getElementById("resID").value;
                var operation = "cancel";
                var notify = "false";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processReservationPayOrCancel", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&operation=" + operation + "&notify=" + notify);
                xmlhttp.onreadystatechange = function (){}
                
            }
        </script>
        <style>
            table, tr{
                border: 1px solid white;
            }

            th, td {
                padding: 15px;
            }
        </style>
    </head>
    <%
        String userID = session.getAttribute("userID").toString();
     
        %>
    <body>
        <%
            int resID = Integer.parseInt(request.getParameter("resID"));
            String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
            String user = "root";
            String password = "";
            Connection Con = null;
            Class.forName("com.mysql.jdbc.Driver");
            Con = DriverManager.getConnection(url, user, password);
            String line = "SELECT * FROM reservation WHERE id = ?";

            PreparedStatement statement = Con.prepareStatement(line);
            statement.setInt(1, resID);
            ResultSet RS = statement.executeQuery();%>
        <main>
            <div class="container">
                <br>
                <h5 class="section-head">
                    <span class="heading">Change a reservation</span>
                    <span class="sub-heading">to change the hotel cancel the reservation first then try to create a new one </span>
                </h5>
                <br><br>

                <%while (RS.next()) {
                            String start = RS.getString("startDate");
                            String end = RS.getString("endDate");%>

                <form id="updateForm" action="makeReservation" method='POST' class="form Log-form">
                    
                    <label>Reservation id: <%= resID%> (unchangeable)</label><br><br>
                    <input id='resID' name = 'resID' type='hidden' value="<%= resID%>">
                    <div class="input-group">
                        <label>start date </label>
                        <input id="start" name="checkIn" type="date" class="input" value="<%= start%>">
                        <span class="bar"></span>
                    </div>
                    <div class="input-group">
                        <label>end date </label>
                        <input id="end" name="checkOut" type="date" class="input" value="<%= end%>">
                        <input name="userID" type="hidden" value="<%= userID%>">
                        <span class="bar"></span>
                    </div>
                    <input type="button" value = "Update" class="btn form-btn btn-purple" onclick="sendajaxUpdateReservation()">
                    <br><br><br>
                    <label id="show_response"></label>
                    </label>
                    
                    
                </form>

                <%}%>
                

                <a href="customerHome.jsp" class="btn form-btn btn-purple">back to home
                    <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                </a>
            </div>
        </main>
    </body>
</html>
