<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Client home</title>
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
        <script>
            function sendajaxViewUserReservations() {
                document.getElementById("show_response2").innerHTML = "";
                var hotelID = document.getElementById("userID").value;
                var view = "user";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processViewReservations", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("userID=" + hotelID + "&view=" + view);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        document.getElementById("show_response1").innerHTML = result;

                    }
                }
            }

            function sendajaxCancelReservation(id) {
                var reservationID = id;
                //alert(reservationID);
                var operation = "cancel";
                var notify = "true";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processReservationPayOrCancel", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&operation=" + operation + "&notify=" + notify);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        if (result.localeCompare("yes") == 0) {
                            sendajaxViewUserReservations();
                        }
                        else if (result.localeCompare("no") == 0) {
                            document.getElementById("show_response2").innerHTML = "Already cancelled";
                        }
                        else {
                            document.getElementById("show_response2").innerHTML = "Something went wrong.. try again";
                        }
                    }
                }
            }

            function validateSearchForm() {
                var city = document.getElementById("city").value;
                var inDate = document.getElementById("inDate").value;
                var outDate = document.getElementById("outDate").value;
                var rooms = document.getElementById("rooms").value;
                var adults = document.getElementById("adults").value;
                var children = document.getElementById("children").value;

                if (city == null || city == "" || city.trim() === '') {
                    document.getElementById("show_response").innerHTML = "Invalid city name !";
                    return false;
                }
                else if (inDate == null || inDate == "" || outDate == null || outDate == "") {
                    document.getElementById("show_response").innerHTML = "Invalid date !";
                    return false;
                }
                else if (adults == null || adults == "" || adults.isNaN() == true) {
                    document.getElementById("show_response").innerHTML = "Invalid number of adults !";
                    return false;
                }
                else if (children == null || children == "" || children.isNaN() == true) {
                    document.getElementById("show_response").innerHTML = "Invalid number of children !";
                    return false;
                }
                else if (rooms == null || rooms == "" || rooms.isNaN() == true) {
                    document.getElementById("show_response").innerHTML = "Invalid number of rooms !";
                    return false;
                }
                return true;

            }

            function sendajaxUpdateInfo() {
                var id = document.getElementById("userID").value;
                var name = document.getElementById("name").value;
                var password = document.getElementById("password").value;
                var email = document.getElementById("email").value;
                var phone = document.getElementById("phone").value;
                if (validateUpdateForm(password, phone, email, name) == true) {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("POST", "processUpdateUserInfo", true);
                    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xmlhttp.send("id=" + id + "&name=" + name + "&password=" + password + "&email=" + email + "&phone=" + phone);
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                            var result = xmlhttp.responseText.toString();
                            if (result.localeCompare("yes") == 0) {
                                location.reload();
                            }
                            else if (result.localeCompare("no") == 0) {
                                document.getElementById("show_response3").innerHTML = "wrong data";
                            }
                            else {
                                document.getElementById("show_response3").innerHTML = "Something went wrong.. enter data again";
                            }
                        }
                    }
                }
            }

            function validateUpdateForm(password, phone, email, name) {
                const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (password == null || password == "" || password.trim() === '') {
                    document.getElementById("show_response4").innerHTML = "Invalid password !";
                    return false;
                }
                else if (name == null || name == "" || name.trim() === '') {
                    document.getElementById("show_response4").innerHTML = "Invalid name !";
                    return false;
                }
                else if (email == null || email == "" || email.trim() === '' || re.test(email) == false) {
                    document.getElementById("show_response4").innerHTML = "Invalid email !";
                    return false;
                }
                else if (phone == null || phone == "" || phone.trim() === '' || isNaN(phone) == true) {
                    document.getElementById("show_response4").innerHTML = "Invalid phone number !";
                    return false;
                }

                return true;
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
        if (session.getAttribute("userID") == null || session.getAttribute("userID").equals("")) {
            response.sendRedirect("Login.jsp");
        }
        String userID = session.getAttribute("userID").toString();
        String url = "jdbc:mysql://localhost:3306/hotelreservationsystem";
        String user = "root";
        String password = "";
        Connection Con = null;
        Class.forName("com.mysql.jdbc.Driver");
        Con = DriverManager.getConnection(url, user, password);
        String line = "SELECT * FROM user WHERE id = ?";
        PreparedStatement statement = Con.prepareStatement(line);
        statement.setString(1, userID);
        ResultSet RS = statement.executeQuery();
        boolean empty = true;
        String phone = "";
        String username = "";
        String Password = "";
        String email = "";
        String name = "";
        while (RS.next()) {
            empty = false;
            name = RS.getString("name");
            phone = RS.getString("phoneNumber");
            username = RS.getString("username");
            Password = RS.getString("password");
            email = RS.getString("email");
        }
        Con.close();
    %>
    <body> 
        <!--The main content-->
        <main>

            <section class="Log">
                <div class="container">
                    <h1><%=username%></h1>
                    <a href="signOut" class="btn form-btn btn-purple">Logout
                        <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                    </a>
                    <br><br><br><br> 


                    <h5 class="section-head">
                        <span class="heading">View your reservations</span>
                        <span class="sub-heading">to change / cancel reservations</span>
                    </h5>
                    <div class="Log-content">
                        <form action="changeReservation.jsp" method='POST' class="form Log-form">
                            <br>
                            <input id='userID' type = "hidden" name="userID" value = <%=userID%>>

                            <input id="submitViewUserReservations" type="button" value = "View reservations" class="btn form-btn btn-purple"
                                   onclick="sendajaxViewUserReservations()"/>
                            <br><br><br>
                            <div id="show_response1" style="color:white ;"></div>
                            <div id="show_response2" style="color:white ;"></div>
                        </form>   

                    </div>
                    <br><br>
                    <h5 class="section-head">
                        <span class="heading">Find hotels to reserve in</span>
                        <span class="sub-heading">anywhere in the world</span>
                    </h5>
                    <br><br>        

                    <div class="Log-content">
                        <form action="processSearch" class="form Log-form" onsubmit="validateSearchForm()">
                            <br><br>
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input id="city" name="city" type="text" class="input" placeholder="City" required>
                                    <span class="bar"></span>
                                </div>
                            </div>

                            <div class="input-group">
                                <label>Check in date </label>
                                <input id="inDate" name="checkInDate" type="date" class="input" placeholder="Check in date" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <label>Check out date </label>
                                <input id="outDate" name="checkOutDate" type="date" class="input" placeholder="Check out date" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input id="adults" name="adults" type="number" class="input" placeholder="Number Of Adults" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input id="children" name="children" type="number" class="input" placeholder="Number of children" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input id="rooms" name="rooms" type="number" class="input" placeholder="Number of rooms" required>
                                <span class="bar"></span>
                            </div>

                            <input type="submit" value = "search" class="btn form-btn btn-purple">
                            <br><br><br>
                            <label id="show_response"></label>
                        </form>   
                    </div>



                    <br><br><br><br>        

                    <h5 class="section-head">
                        <span class="heading">View & Update your personal info</span>
                        <span class="sub-heading">Not allowed to change the username</span>
                    </h5>
                    <div class="Log-content">
                        <form id='personalInfoForm' method='POST' class="form Log-form">
                            <label>Username : <%=username + " (Unchangeable)"%></label>
                            <br><br>
                            <input id='userID' class="input" type = "hidden" name="userID" placeholder = <%=userID%> value = <%=userID%>>
                            <input id='name' class="input" type = "text" name="name" value = '<%=name%>'>
                            <input id='password' class="input" type = "text" name="password" placeholder = <%=Password%> value = <%=Password%>>
                            <input id='phone' class="input" type = "text" name="phone" placeholder = <%=phone%> value = <%=phone%>>
                            <input id='email' class="input" type = "email" name="email" placeholder = <%=email%> value = <%=email%>>
                            <input id="submitChangeInfo" type="button" value = "Update my info" class="btn form-btn btn-purple"
                                   onclick="sendajaxUpdateInfo()"/>
                            <br><br><br>
                            <label id="show_response3"></label>
                            <label id="show_response4"></label>
                        </form>   

                    </div>

                </div>
            </section>
        </main>

    </body>
</html>