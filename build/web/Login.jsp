<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie-edge">
    <title>Sign in</title>
    <!--Font awesome CDN-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <!--Local style sheet-->
    <link rel="stylesheet" href="styles.css">
    <script>
            function sendajax() {
                var password = document.getElementById("password").value;
                var username = document.getElementById("username").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("POST", "processLogin", true);
                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlhttp.send("username=" + username +"&password=" + password);
                xmlhttp.onreadystatechange = function (){
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                        var result = xmlhttp.responseText.toString() ;
                        alert("mess = |" + result + "|");
                        if(result.localeCompare("yes") == 0){
                            window.location.replace("customerHome.jsp");
                        }
                        else if(result.localeCompare("no") == 0){
                            document.getElementById("show_response").innerHTML= "Wrong user data"; 
                        }
                        else{
                            document.getElementById("show_response").innerHTML= "Something went wrong.. enter data again"; 
                        }
                    }
                }
            }
            
            
        </script>
</head>
<body> 
    <!--The main content-->
    <main>
        <section class="Log">
            <div class="container">
                <h5 class="section-head">
                    <span class="heading">Log in</span>
                    <span class="sub-heading">Join our community</span>
                </h5>
                <div class="Log-content">
                    <div class="traveler-warp">
                        <img src="img/Traveler2.jpg">
                    </div>
                    <form action="" class="form Log-form">
                        <br>
                        <label>Not registered yet?</label>
                        <a href="SignUp.jsp" class="btn form-btn btn-purple">Register now
                            <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                        </a>
                        <div class="input-group-wrap">
                            <div class="input-group">
                                <input id = "username" name="username" type="text" class="input" placeholder="Username" required>
                                <span class="bar"></span>
                            </div>
                        </div>

                        <div class="input-group">
                            <input  id = "password" name="password" type="password" class="input" placeholder="Password" required>
                            <span class="bar"></span>
                        </div>
                        <input id="submitSignin" type="button" value = "Sign in" class="btn form-btn btn-purple" onclick="sendajax()"/>
                            <br><br><br>
                        <label id="show_response"></label>
                    </form>   
                </div>
            </div>
        </section>
    </main>

  
</body>
</html>