<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Search</title>
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
        <script>
            function sendajaxViewUserReservations() {
                document.getElementById("show_response2").innerHTML = "" ;
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
    <body> 
        <!--The main content-->
        <main>
            <section class="Log">
                <div class="container">
                    <%
                        String userID = session.getAttribute("userID").toString();
                    %>
                    <br><br><br><br>        

                    <h5 class="section-head">
                        <span class="heading">View your reservations</span>
                        <span class="sub-heading">to change / cancel reservations</span>
                    </h5>
                    <div class="Log-content">
                        <form action="" class="form Log-form">
                            <br>
                            <input id='userID' type = "hidden" name="userID" value = <%=userID%>>

                            <input id="submitViewUserReservations" type="button" value = "View reservations" class="btn form-btn btn-purple" onclick="sendajaxViewUserReservations()"/>
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
                        <form action="processSearch" class="form Log-form">
                            <br><br>
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input name="city" type="text" class="input" placeholder="City" required>
                                    <span class="bar"></span>
                                </div>
                            </div>

                            <div class="input-group">
                                <label>Check in date </label>
                                <input name="checkInDate" type="date" class="input" placeholder="Check in date" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <label>Check out date </label>
                                <input name="checkOutDate" type="date" class="input" placeholder="Check out date" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input name="adults" type="number" class="input" placeholder="Number Of Adults" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input name="children" type="number" class="input" placeholder="Number of children" required>
                                <span class="bar"></span>
                            </div>

                            <div class="input-group">
                                <input name="rooms" type="number" class="input" placeholder="Number of rooms" required>
                                <span class="bar"></span>
                            </div>

                            <input type="submit" value = "search" class="btn form-btn btn-purple">
                        </form>   
                    </div>
                </div>
            </section>
        </main>

    </body>
</html>