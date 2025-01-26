<!DOCTYPE html>  
<html>  
<head>  
    <title>Received Data</title>  
</head>  
<body>  
    <h1>Data Received from Python Script</h1>  
    
    @if(isset($data))  
        <ul>  
            @foreach($data as $key => $value)  
                <li><strong>{{ $key }}</strong>: {{ $value }}</li>  
            @endforeach  
        </ul>  
    @else  
        <p>No data received.</p>  
    @endif  
</body>  
</html>