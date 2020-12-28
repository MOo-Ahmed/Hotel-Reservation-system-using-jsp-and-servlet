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
</head>
<body> 
    <!--The main content-->
    <main>
        <section class="Log">
            <div class="container">
                <div class="Log-content">
                    <form action="" class="form Log-form">
                        <br>
                        <label>Not registered yet?</label>
                        <a href="SignUp.jsp" class="btn form-btn btn-purple">Register now
                            <span class="dots"><i class="fas fa-ellipsis-h"></i></span>
                        </a>
                        <div class="input-group-wrap">
                            <div class="input-group">
                                <input name="username" type="text" class="input" placeholder="Username" required>
                                <span class="bar"></span>
                            </div>
                        </div>

                        <div class="input-group">
                            <input name="password" type="password" class="input" placeholder="Password" required>
                            <span class="bar"></span>
                        </div>

                        <input type="submit" value = "Log in" class="btn form-btn btn-purple">
                    </form>   
                </div>
            </div>
        </section>
    </main>

  
</body>
</html>