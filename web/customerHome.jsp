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
</head>
<body> 
    <!--The main content-->
    <main>
        <section class="Log">
            <div class="container">
                <div class="Log-content">
                    <form action="processSearch" class="form Log-form">
                        <br>
                        <label>Find hotels to reserve in </label><br><br>
                        
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