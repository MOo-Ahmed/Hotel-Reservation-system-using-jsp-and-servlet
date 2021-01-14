<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Search users</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Font awesome CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <!--Local style sheet-->
        <link rel="stylesheet" href="styles.css">
        <script>
            function validateSearchUsersForm() {
                var name = document.getElementById("name").value;

                if (name == null || name == "" || name.trim() === '') {
                    document.getElementById("show_response").innerHTML = "Invalid name !";
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <!--The main content-->
        <main>
            <div class="container">
                <br>
            <h3 class="heading" align="center">Search for clients </h3><br>
                <br>
                <form action="processSearchUsers" class="form Log-form" onsubmit="return validateSearchUsersForm()">
                    <br>
                    <div class="input-group">
                        <label>User Name </label>
                        <input id="name" name="name" type="text" class="input" placeholder="(eg.Ahmed)" required>
                        <span class="bar"></span>
                    </div>

                    <input type="submit" value = "search" class="btn form-btn btn-purple">
                    <br><br>
                    <label id="show_response"></label>
                </form>
            </div>
        </main>
    </body>
</html>
