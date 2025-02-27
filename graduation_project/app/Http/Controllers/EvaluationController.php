<?php

namespace App\Http\Controllers;
use App\Models\Points;
use Illuminate\Support\Facades\Log;

use Illuminate\Http\Request;



namespace App\Http\Controllers;

use App\Models\Points;
use App\Models\Evaluation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class EvaluationController extends Controller
{
    // public function evaluate(Request $request)
    // {
    //     // 1. Get data from database
    //     $points = Points::where('created_at', '>=', now()->subDays(7))->get();
        
    //     // 2. Format data for Python
    //     $payload = [];
    //     foreach ($points as $point) {
    //         $payload[$point->employee_id][] = [
    //             'points_count' => $point->points_count,
    //             'description' => $point->description,
    //             'created_at' => $point->created_at->toDateTimeString()
    //         ];
    //     }
    //     Log::info('Payload sent to Python script:', ['payload' => $payload]);
    //     $payload = [];
    //     foreach ($points as $point) {
    //         $payload[$point->employee_id][] = [
    //             'points_count' => $point->points_count,
    //             'description' => $point->description,
    //             'created_at' => $point->created_at->toDateTimeString()
    //         ];
    //     }
        

    //     // return $payload;
        
    //     // 3. Convert to JSON and log the JSON payload
    //     $jsonPayload = json_encode($payload); // Ensure the payload is valid JSON
    //     $tempFile = tmpfile();
    //     fwrite($tempFile, $jsonPayload);
    //     $tempFilePath = stream_get_meta_data($tempFile)['uri']; // Get file path
        
    //     // 4. Execute Python script with file path
    //     $pythonScript = base_path('build_fuzzy.py');
    //     $command = escapeshellcmd("python \"{$pythonScript}\"") . " " . 
    //                escapeshellarg($tempFilePath) . " 2>&1";
        
    //     $output = [];
    //     $returnCode = 0;
    //     exec($command, $output, $returnCode);
        
    //     // 5. Handle response
    //     if ($returnCode === 0) {
    //         try {
    //             $result = json_decode(implode("\n", $output), true);
                
    //             // Save to database
    //             foreach ($result as $employeeId => $evaluation) {
    //                 Evaluation::create([
    //                     'employee_id' => $employeeId,
    //                     'result' => $evaluation['score'],
    //                     'feedback' => $evaluation['feedback']
    //                 ]);
    //             }
                
    //             return response()->json([
    //                 'status' => 'success',
    //                 'data' => $result
    //             ]);
                
    //         } catch (\Exception $e) {
    //             Log::error('Python output parsing failed: ' . $e->getMessage());
    //             return response()->json([
    //                 'status' => 'error',
    //                 'message' => 'Failed to parse Python output'
    //             ], 500);
    //         }
    //     }
        
    //     // Handle Python script error
    //     Log::error('Python script failed: ' . implode("\n", $output));
    //     return response()->json([
    //         'status' => 'error',
    //         'message' => 'Evaluation failed',
    //         'python_error' => implode("\n", $output)
    //     ], 500);
    // }


    public function evaluate(Request $request)  
{  
    $points = Points::where('created_at', '>=', now()->subDays(7))->get();  
    
    // Prepare the payload  
    $payload = [];  
    foreach ($points as $point) {  
        $payload[$point->employee_id][] = [  
            'points_count' => $point->points_count,  
            'description' => $point->description,  
            'created_at' => $point->created_at->toDateTimeString(),  
        ];  
    }  

    $jsonPayload = json_encode($payload);  
    Log::info('JSON Payload sent to Python script:', ['jsonPayload' => $jsonPayload]);  

    $tempFile = tmpfile();  
    fwrite($tempFile, $jsonPayload);  
    $tempFilePath = stream_get_meta_data($tempFile)['uri'];  

    // Run Python script  
    $pythonScript = base_path('build_fuzzy.py');  
    $command = escapeshellcmd("python \"{$pythonScript}\"") . " " .   
               escapeshellarg($tempFilePath);  

    $output = [];  
    $returnCode = 0;  
    exec($command . " 2>&1", $output, $returnCode); // Capture both output and errors  

    Log::info('Python Script Output:', ['output' => implode("\n", $output)]);  
    
    // Handle the successful execution of the script  
    if ($returnCode === 0) {  
        try {  
            $result = json_decode(implode("\n", $output), true);  
            if (json_last_error() !== JSON_ERROR_NONE) {  
                throw new \Exception('JSON decode error: ' . json_last_error_msg());  
            }  
            return response()->json([  
                'status' => 'success',  
                'data' => $result,  
            ],200);  
        } catch (\Exception $e) {  
            Log::error('Failed to parse Python output: ' . $e->getMessage());  
            return response()->json([  
                'status' => 'error',  
                'message' => 'Failed to parse Python output',  
                'output' => implode("\n", $output), // Include the output in the response  
            ], 500);  
        }  
    }  

    // Log error if Python script fails  
    return response()->json([  
        'status' => 'error',  
        'message' => 'Evaluation failed',  
        'python_error' => implode("\n", $output),  
    ], 500);  
}  
}
