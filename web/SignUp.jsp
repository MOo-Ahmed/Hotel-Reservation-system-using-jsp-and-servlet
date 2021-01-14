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
                var name = document.getElementById("name").value;
                var username = document.getElementById("username").value;
                var email = document.getElementById("email").value;
                var phone = document.getElementById("phone").value;
                if(validateSignUpForm(username, phone , email, name) == true){
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("POST", "validateSignUp", true);
                    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xmlhttp.send("name=" + name +"&username=" + username + "&email=" + email + "&phone=" + phone);
                    xmlhttp.onreadystatechange = function (){
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
                            var result = xmlhttp.responseText.toString() ;
                            if(result.localeCompare("yes") == 0){
                                document.getElementById("show_response").innerHTML= "Successfully registered .. Find your password on your email .. If your receive it use it in Log in page"; 
                            }
                            else if(result.localeCompare("no") == 0){
                                document.getElementById("show_response").innerHTML= "Username already exists"; 
                            }
                            else{
                                document.getElementById("show_response").innerHTML= "Something went wrong.. enter data again"; 
                            }
                        }
                    }
                }
            }
            
            function validateSignUpForm(username, phone , email, name){
                const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (username == null || username == "" || username.trim() === ''){
                    document.getElementById("show_response").innerHTML = "Invalid username !" ;
                    return false ;
                }
                else if(name == null || name == "" || name.trim() === ''){
                    document.getElementById("show_response").innerHTML = "Invalid name !" ;
                    return false ;
                }
                else if(email == null || email == "" || email.trim() === '' || re.test(email) == false){
                    document.getElementById("show_response").innerHTML = "Invalid email !" ;
                    return false ;
                }
                else if(phone == null || phone == "" || phone.trim() === '' || phone.isNaN()){
                    document.getElementById("show_response").innerHTML = "Invalid phone number !" ;
                    return false ;
                }
                return true ;
            }
           
			var code;
    function createCaptcha() {
        //clear the contents of captcha div first 
        document.getElementById('captcha').innerHTML = "";
        var charsArray =
            "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%^&*";
        var lengthOtp = 6;
        var captcha = [];
        for (var i = 0; i < lengthOtp; i++) {
            //below code will not allow Repetition of Characters
            var index = Math.floor(Math.random() * charsArray.length + 1); //get the next character from the array
            if (captcha.indexOf(charsArray[index]) == -1)
                captcha.push(charsArray[index]);
            else i--;
        }
        var canv = document.createElement("canvas");
        canv.id = "captcha";
        canv.width = 200;
        canv.height = 50;
        var ctx = canv.getContext("2d");
        ctx.font = " bold 25px Georgia";
        ctx.fillStyle = 'white';
        ctx.fillText(captcha.join(""), 0, 30);  
        //storing captcha so that can validate you can save it somewhere else according to your specific requirements
        code = captcha.join("");
        document.getElementById("captcha").appendChild(canv); // adds the canvas to the body element
    }
    function validateCaptcha() {
        event.preventDefault();
        debugger
        if (document.getElementById("cpatchaTextBox").value == code) {
            alert("Valid Captcha")
        } else {
            alert("Invalid Captcha. try Again");
            createCaptcha();
        }
    }
        </script>
		<style>
    canvas {
        /*prevent interaction with the canvas*/
        pointer-events: none;
    }
    #cpatchaTextBox{
        padding: 12px 20px;
        display: inline-block;
        border:0;
        border-bottom:solid 2px white;
        outline:none;
        box-sizing: border-box;
        background-color: transparent;
        color: white;   
    }
</style>
    </head>
    <body onload="createCaptcha()"> 
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
                        <form action="" class="form Log-form">
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
                                
                                <div class="input-group">
                                    <input id="phone" name="phone" type="text" class="input" placeholder="Phone number" required>
                                    <span class="bar"></span>
                                </div>
                                
								<div id="captcha">
                                    </div>
                                    <input type="text" placeholder="Captcha" id="cpatchaTextBox" />
                                
                            </div>
                            <input id="submitSignup" type="button" value = "Sign up" class="btn form-btn btn-purple" onclick="sendajax();validateCaptcha()"/>
                            <br><br><br>
                            <label id="show_response"></label>
                            <!--<input type="submit" value = "Sign up" class="btn form-btn btn-purple">!-->
                            
                        </form> 
                        
                    </div>
                </div>
            </section>
        </main>


    </body>
</html>