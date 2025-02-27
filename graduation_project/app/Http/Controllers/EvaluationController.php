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
            // return response()->json([  
            //     'status' => 'success',  
            //     'data' => $result,  
            // ],200);  

            return response()->json([  
                'status' => 'success',  
                'results' => $result['results'],  // Only return the results  
            ], 200);  

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
