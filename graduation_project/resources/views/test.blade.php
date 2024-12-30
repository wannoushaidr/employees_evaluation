


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <h1>test blade </h1>
<h1>{{$name}}</h1>

<?php
if(DB::connection()->getpdo()){
    echo "Successfully connected to DB and DB name is " . DB::connection()->getDatabaseName();


}

?>


</body>
</html>
