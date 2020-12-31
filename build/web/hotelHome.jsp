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
    <script>
            function sendajaxCheckIn() {
                var reservationID = document.getElementById("InReservationID").value;
                //var hotelID = document.getElementById("hotelID").value;
                var today = getCurrentDate('-');
                //alert(reservationID + " " + today );
                var check = "in" ;
                
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processCheckInOut", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID +"&date=" + today + "&check=" + check);
                xmlhttp.onreadystatechange = function (){
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                        var result = xmlhttp.responseText.toString() ;
                        alert("mess = |" + result + "|");
                        if(result.localeCompare("yes") == 0){
                            document.getElementById("show_response1").innerHTML= "Check in Done !";
                        }
                        else if(result.localeCompare("no") == 0){
                            document.getElementById("show_response1").innerHTML= "Wrong Reservation ID"; 
                        }
                        else{
                            document.getElementById("show_response1").innerHTML= "Something went wrong.. enter data again"; 
                        }
                    }
                }
            }
            function getCurrentDate(sp){
                today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth()+1; //As January is 0.
                var yyyy = today.getFullYear();

                if(dd<10) dd='0'+dd;
                if(mm<10) mm='0'+mm;
                return (yyyy+sp+mm+sp+dd);
            }
            function sendajaxCheckOut() {
                var reservationID = document.getElementById("OutReservationID").value;
                //var hotelID = document.getElementById("hotelID").value;
                var today = getCurrentDate('-');
                var check = "out" ;

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processCheckInOut", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("reservationID=" + reservationID +"&date=" + today + "&check=" + check);
                xmlhttp.onreadystatechange = function (){
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                        var result = xmlhttp.responseText.toString() ;
                        alert("mess = |" + result + "|");
                        if(result.localeCompare("yes") == 0){
                            document.getElementById("show_response2").innerHTML= "Check out Done !";
                        }
                        else if(result.localeCompare("no") == 0){
                            document.getElementById("show_response2").innerHTML= "Wrong Reservation ID or payment isn't done"; 
                        }
                        else{
                            document.getElementById("show_response2").innerHTML= "Something went wrong.. enter data again"; 
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
                          int hotelID = 1 ;  
                        %>    
                        
                        <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID %>>

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
                        
                        <input id='hotelID' type = "hidden" name="hotelID" value = <%=hotelID %>>

                        <input id="submitcheckin" type="button" value = "Check out" class="btn form-btn btn-purple" onclick="sendajaxCheckOut()"/>
                            <br><br><br>
                        <label id="show_response2"></label>
                    </form>   
                </div>
            </div>
        </section>
    </main>

  
</body>
</html>