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
    </head>
    <body>
        <!--The main content-->
        <main>
            <div class="container">
                <br>
                <form action="processSearchUsers" class="form Log-form">
                    <br>
                    <label>Search for clients </label><br><br>

                    <div class="input-group">
                        <label>User Name </label>
                        <input name="name" type="text" class="input" placeholder="(eg.Ahmed)" required>
                        <span class="bar"></span>
                    </div>

                    <input type="submit" value = "search" class="btn form-btn btn-purple">
                </form>
            </div>
        </main>
    </body>
</html>
