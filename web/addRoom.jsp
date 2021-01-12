<%-- 
    Document   : addRoom
    Created on : Jan 12, 2021, 2:30:07 PM
    Author     : Kareem_Eltemsah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add room</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <main>
            <section class="Log">
                <div class="container">
                    <h5 class="section-head">
                        <span class="heading">Add room</span>
                    </h5>
                    <div class="Log-content">
                        <form action="processAddRoom" class="form Log-form">
                            <br>
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input name="name" type="text" class="input" placeholder="room name" required>
                                    <span class="bar"></span>
                                </div>

                                <div class="input-group">
                                    <input name="price" type="number" class="input" placeholder="price" required>
                                    <span class="bar"></span>
                                </div>

                                <div class="input-group">
                                    <input name="facilities" type="text" class="input" placeholder="facilities" required>
                                    <span class="bar"></span>
                                </div>
                                
                                <div class="input-group">
                                    <input name="roomTypeID" type="radio" value="1" required>
                                    <label>Adults</label><br>
                                    <input name="roomTypeID" type="radio" value="2" required>
                                    <label>Children</label><br>
                                    <span class="bar"></span>
                                </div>
                                
                            </div>
                            <% String hotelID = request.getParameter("hotelID"); %>
                            <input type="hidden" name="hotelID" value = "<%=hotelID%>">
                            <input type="submit" value = "Add Room" class="btn form-btn btn-purple"/>
                        </form>
                    </div>
                    <a href="hotelHome.jsp?hotelID=<%=hotelID%>" class="btn form-btn btn-purple">back to hotel home
                        <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                    </a>
                </div>
            </section>
        </main>
    </body>
</html>
