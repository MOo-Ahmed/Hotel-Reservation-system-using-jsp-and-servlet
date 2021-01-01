<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Hotel Home Page</title>
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">

        <style>
            table, tr{
                border: 1px solid white;
            }

            th, td {
                padding: 10px;
            }
        </style>
        <script>
            function sendajaxCheckIn() {
                var reservationID = document.getElementById("InReservationID").value;
                //var hotelID = document.getElementById("hotelID").value;
                var today = getCurrentDate('-');
                var check = "in";

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processCheckInOut", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&date=" + today + "&check=" + check);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        alert("mess = |" + result + "|");
                        if (result.localeCompare("yes") == 0) {
                            document.getElementById("show_response1").innerHTML = "Check in Done !";
                        }
                        else if (result.localeCompare("no") == 0) {
                            document.getElementById("show_response1").innerHTML = "Wrong Reservation ID";
                        }
                        else {
                            document.getElementById("show_response1").innerHTML = "Something went wrong.. enter data again";
                        }
                    }
                }
            }
            function getCurrentDate(sp) {
                today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //As January is 0.
                var yyyy = today.getFullYear();

                if (dd < 10)
                    dd = '0' + dd;
                if (mm < 10)
                    mm = '0' + mm;
                return (yyyy + sp + mm + sp + dd);
            }
            function sendajaxCheckOut() {
                var reservationID = document.getElementById("OutReservationID").value;
                //var hotelID = document.getElementById("hotelID").value;
                var today = getCurrentDate('-');
                var check = "out";

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processCheckInOut", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&date=" + today + "&check=" + check);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        //alert("mess = |" + result + "|");
                        if (result.localeCompare("yes") == 0) {
                            document.getElementById("show_response2").innerHTML = "Check out Done !";
                        }
                        else if (result.localeCompare("no") == 0) {
                            document.getElementById("show_response2").innerHTML = "Wrong Reservation ID or payment isn't done";
                        }
                        else {
                            document.getElementById("show_response2").innerHTML = "Something went wrong.. enter data again";
                        }
                    }
                }
            }
            function sendajaxViewCurrRes() {
                var hotelID = document.getElementById("hotelID").value;
                var view = "current" ;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processViewReservations", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("hotelID=" + hotelID + "&view=" + view);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        //alert("mess = |" + result + "|");
                        document.getElementById("show_response3").innerHTML = result;

                    }
                }
            }
            function sendajaxViewSpecificRes() {
                var hotelID = document.getElementById("hotelID").value;
                var from = document.getElementById("fromDate").value;
                var to = document.getElementById("toDate").value;
                var view = "specific" ;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processViewReservations", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("hotelID=" + hotelID + "&view=" + view + "&from=" + from + "&to=" + to);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        //alert("mess = |" + result + "|");
                        document.getElementById("show_response5").innerHTML = result;
                    }
                }
            }
            function sendajaxConfirmPayment(id) {
                var reservationID = id;
                var operation = "pay";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processReservationPayOrCancel", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&operation=" + operation);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        //alert("mess = |" + result + "|");
                        if (result.localeCompare("yes") == 0) {
                            sendajaxViewCurrRes();
                        }
                        else if (result.localeCompare("no") == 0) {
                            document.getElementById("show_response4").innerHTML = "Already paid";
                        }
                        else {
                            document.getElementById("show_response4").innerHTML = "Something went wrong.. try again";
                        }
                    }
                }
            }
            function sendajaxCancelReservation(id) {
                var reservationID = id;
                alert(reservationID);
                var operation = "cancel";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processReservationPayOrCancel", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID + "&operation=" + operation);
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var result = xmlhttp.responseText.toString();
                        //alert("mess = |" + result + "|");
                        if (result.localeCompare("yes") == 0) {
                            sendajaxViewCurrRes();
                        }
                        else if (result.localeCompare("no") == 0) {
                            document.getElementById("show_response4").innerHTML = "Already cancelled";
                        }
                        else {
                            document.getElementById("show_response4").innerHTML = "Something went wrong.. try again";
                        }
                    }
                }
            }

        </script>
    </head>
    <body> 
        <main>
            <section class="Log">
                <div class="container">
                    <h5 class="section-head">
                        <span class="heading">Check Customer Check In</span>
                        <!--<span class="sub-heading">Join our community</span>-->
                    </h5>
                    <div class="Log-content">
                        <div class="traveler-warp">
                            <img src="img/guestCheckIn.jpg">
                        </div>
                        <form action="" class="form Log-form">
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input id = "InReservationID" name="reservationID" type="text" class="input" placeholder="Reservation ID" required>
                                    <span class="bar"></span>
                                </div>
                            </div>
                            <%
                                int hotelID = 1;
                            %>    

                            <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID%>>

                            <input id="submitcheckin" type="button" value = "Check in" class="btn form-btn btn-purple" onclick="sendajaxCheckIn()"/>
                            <br><br><br>
                            <label id="show_response1"></label>
                        </form>  

                    </div>

                    <br><br><br><br>        

                    <h5 class="section-head">
                        <span class="heading">Customer Check Out</span>
                        <!--<span class="sub-heading">Join our community</span>-->
                    </h5>
                    <div class="Log-content">
                        <div class="traveler-warp">
                            <img src="img/guestCheckOut.jpg">
                        </div>
                        <form action="" class="form Log-form">
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input id = "OutReservationID" name="reservationID" type="text" class="input" placeholder="Reservation ID" required>
                                    <span class="bar"></span>
                                </div>
                            </div>

                            <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID%>>

                            <input id="submitcheckin" type="button" value = "Check out" class="btn form-btn btn-purple" onclick="sendajaxCheckOut()"/>
                            <br><br><br>
                            <label id="show_response2"></label>
                        </form>   
                    </div>

                    <br><br><br><br>        

                    <h5 class="section-head">
                        <span class="heading">View hotel reservations</span>
                        <span class="sub-heading">current reservations</span>
                    </h5>
                    <div class="Log-content">
                        <form action="" class="form Log-form">
                            <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID%>>

                            <input id="submitViewCurrentReservations" type="button" value = "View reservations" class="btn form-btn btn-purple" onclick="sendajaxViewCurrRes()"/>
                            <br><br><br>
                            <div id="show_response3" style="color:white ;"></div>
                            <div id="show_response4" style="color:white ;"></div>
                        </form>   
                    </div>


                    <h5 class="section-head">
                        <span class="heading">View hotel reservations</span>
                        <span class="sub-heading">In a specific period</span>
                    </h5>
                    <div class="Log-content">
                        <form action="" class="form Log-form">
                            <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID%>>
                            <input id='fromDate' type='date' Placeholder ='From' name='from'  class="input" required> 
                            <input id='toDate' type='date' Placeholder ='To' name='to'  class="input" required>
                            
                            <input id="submitViewSpecificReservations" type="button" value = "View reservations" class="btn form-btn btn-purple" onclick="sendajaxViewSpecificRes()"/>
                            <br><br><br>
                            <div id="show_response5" style="color:white ;"></div>
                            <div id="show_response6" style="color:white ;"></div>
                        </form>   
                    </div>

                </div>
            </section>
        </main>


    </body>
</html>