<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie-edge">
        <title>Sign up</title>
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
        <script>
            function sendajax() {
                //alert("Hello");
                var name = document.getElementById("name").value;
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("POST", "validateSignUp", true);
                    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xmlhttp.send("name=" + name);
                    xmlhttp.onreadystatechange = function (){
                        //alert("Hi");
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                            document.getElementById("show_response").innerHTML=xmlhttp.responseText;
                        }
                    }
            }
            
            function submitSignUpForm(){
                
            }
        </script>
    </head>
    <body> 
        <!--The main content-->
        <main>
            <section class="Log">
                <div class="container">
                    <h5 class="section-head">
                        <span class="heading">Sign up</span>
                        <span class="sub-heading">Join our community</span>
                    </h5>
                    <div class="Log-content">
                        <div class="traveler-warp">
                            <img src="img/Traveler.jpg">
                        </div>
                        <form action="" class="form Log-form" onsubmit="submitSignUpForm()">
                            <br>
                            <label>Already registered ?</label>
                            <a href="Login.jsp" class="btn form-btn btn-purple">Login now
                                <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                            </a>
                            <div class="input-group-wrap">
                                <div class="input-group">
                                    <input id="name" name="name" type="text" class="input" placeholder="Name" required>
                                    <span class="bar"></span>
                                </div>

                                <div class="input-group">
                                    <input id="username" name="username" type="text" class="input" placeholder="Username" required>
                                    <span class="bar"></span>
                                </div>

                                <div class="input-group">
                                    <input id="email" name="email" type="email" class="input" placeholder="E-mail" required>
                                    <span class="bar"></span>
                                </div>

                            </div>
                            <input id="submitSignup" type="button" value = "ckeck" class="btn form-btn btn-purple" onclick="sendajax()"/>
                            <br>
                            <label id="show_response"></label>
                            <input type="submit" value = "Sign up" class="btn form-btn btn-purple">
                            
                        </form> 
                        
                    </div>
                </div>
            </section>
        </main>


    </body>
</html>