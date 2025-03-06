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
    

//     public function evaluate(Request $request)  
// {  
//     $points = Points::where('created_at', '>=', now()->subDays(7))->get();  
    
//     // Prepare the payload  
//     $payload = [];  
//     foreach ($points as $point) {  
//         $payload[$point->employee_id][] = [  
//             'points_count' => $point->points_count,  
//             'description' => $point->description,  
//             'created_at' => $point->created_at->toDateTimeString(),  
//         ];  
//     }  

//     $jsonPayload = json_encode($payload);  
//     Log::info('JSON Payload sent to Python script:', ['jsonPayload' => $jsonPayload]);  

//     $tempFile = tmpfile();  
//     fwrite($tempFile, $jsonPayload);  
//     $tempFilePath = stream_get_meta_data($tempFile)['uri'];  

//     // Run Python script  
//     $pythonScript = base_path('build_fuzzy.py');  
//     $command = escapeshellcmd("python \"{$pythonScript}\"") . " " .   
//                escapeshellarg($tempFilePath);  

//     $output = [];  
//     $returnCode = 0;  
//     exec($command . " 2>&1", $output, $returnCode); // Capture both output and errors  

//     Log::info('Python Script Output:', ['output' => implode("\n", $output)]);  
    
//     // Handle the successful execution of the script  
//     if ($returnCode === 0) {  
//         try {  
//             $result = json_decode(implode("\n", $output), true);  
//             if (json_last_error() !== JSON_ERROR_NONE) {  
//                 throw new \Exception('JSON decode error: ' . json_last_error_msg());  
//             }  
            
//             // Save evaluations to the database  
//             if (isset($result['results'])) {  
//                 foreach ($result['results'] as $evaluationData) {  
//                     // Create a new evaluation record  
//                     Evaluation::create([  
//                         'employee_id' => $evaluationData['employee_id'],  
//                         'evaluation' => $evaluationData['evaluation'],  
//                     ]);  
//                 }  
//             }  

//             return response()->json([  
//                 'status' => 'success',  
//                 'results' => $result['results'],  // Only return the results  
//             ], 200);  

//         } catch (\Exception $e) {  
//             Log::error('Failed to parse Python output: ' . $e->getMessage());  
//             return response()->json([  
//                 'status' => 'error',  
//                 'message' => 'Failed to parse Python output',  
//                 'output' => implode("\n", $output), // Include the output in the response  
//             ], 500);  
//         }  
//     }  

//     // Log error if Python script fails  
//     return response()->json([  
//         'status' => 'error',  
//         'message' => 'Evaluation failed',  
//         'python_error' => implode("\n", $output),  
//     ], 500);  
// }  
// }


public function get_daily_evaluation()  
{  
    // Retrieve all evaluations  
    // $evaluations = Evaluation::all(); // You can also use paginate or filter as needed  
    $evaluations = Evaluation::where('type', 'daily')->get();  


    // Return evaluations as JSON  
    return response()->json($evaluations);  
}  

public function get_weekly_evaluation()  
{  
    // Retrieve all evaluations  
    // $evaluations = Evaluation::all(); // You can also use paginate or filter as needed  
    $evaluations = Evaluation::where('type', 'weekly')->get();

    // Return evaluations as JSON  
    return response()->json($evaluations);  
}  

public function get_monthly_evaluation()  
{  
    // Retrieve all evaluations  
    // $evaluations = Evaluation::all(); // You can also use paginate or filter as needed  
    $evaluations = Evaluation::where('type', 'monthly')->get();

    // Return evaluations as JSON  
    return response()->json($evaluations);  
}  


public function week_evaluate(Request $request)  
{  
    // Fetch points data for the last 7 days  
    $points = Points::where('created_at', '>=', now()->subDays(7))->get();  
    // return $points;

    // Prepare an array to hold the average points per description for each employee  
    $averagePoints = [];  

    foreach ($points as $point) {  
        $employeeId = $point->employee_id;  
        $description = $point->description;  
        $pointsCount = $point->points_count;  

        // Initialize the employee in the results array if not already done  
        if (!isset($averagePoints[$employeeId])) {  
            $averagePoints[$employeeId] = [];  
        }  

        // Initialize the description in the employee's array if not already done  
        if (!isset($averagePoints[$employeeId][$description])) {  
            $averagePoints[$employeeId][$description] = [  
                'total_points' => 0,  
                'count' => 0,  
            ];  
        }  

        // Sum the points and increment the count for the description  
        $averagePoints[$employeeId][$description]['total_points'] += $pointsCount;  
        $averagePoints[$employeeId][$description]['count'] += 1;  
    }  

    // Calculate the average points for each description per employee  
    foreach ($averagePoints as $employeeId => $descriptions) {  
        foreach ($descriptions as $description => $data) {  
            if ($data['count'] > 0) {  
                $averagePoints[$employeeId][$description]['average'] = $data['total_points'] / $data['count'];  
            } else {  
                $averagePoints[$employeeId][$description]['average'] = 0;  
            }  
        }  
    }  


$payload = [];  
foreach ($averagePoints as $employeeId => $descriptions) {  
    $dataToSend = []; // Initialize an array to hold the data for each employee  

    // Iterate through all available descriptions  
    foreach ($descriptions as $description => $value) {  
        // Only include descriptions that have an 'average' value  
        if (isset($value['average'])) {  
            $dataToSend[$description] = [  $value['average']];
                // 'average' => $value['average'],  
            // ];  
        }  
    }  

    // Only add to the payload if there's at least one description with an average  
    if (!empty($dataToSend)) {  
        $payload[] = [  
            'employee_id' => $employeeId,  
            'data' => $dataToSend, // Add all descriptions with their averages  
        ];  
    }  
}  
// return $payload;

$jsonPayload = json_encode($payload);  
Log::info('JSON Payload sent to Python script:', ['jsonPayload' => $jsonPayload]);  

$tempFile = tmpfile();  
fwrite($tempFile, $jsonPayload);  
$tempFilePath = stream_get_meta_data($tempFile)['uri'];  

// Run Python script  
$pythonScript = base_path('build_fuzzy.py');  
// $command = escapeshellcmd("python \"{$pythonScript}\"") . " " . escapeshellarg($tempFilePath); 
$command = escapeshellcmd("python \"{$pythonScript}\" " . escapeshellarg($tempFilePath) . " 2>/dev/null");  

 

$output = [];  
$returnCode = 0;  
// exec($command . " 2>&1", $output, $returnCode); // Capture both output and errors  
exec($command , $output, $returnCode); // Capture both output and errors  


Log::info('Python Script Output:', ['output' => implode("\n", $output)]);  

// Attempt to decode the JSON output  
$jsonOutput = trim(implode("\n", $output));  // Remove any leading/trailing whitespace
if (strpos($jsonOutput, '<!--') !== false) {  
    $jsonOutput = substr($jsonOutput, strpos($jsonOutput, '{')); // Get everything from the first '{' onward  
}  
// return jsonOutput;

// Handle the successful execution of the script  
if ($returnCode === 0) {  
    // Try to decode the final output  
    $jsonOutput = trim(implode("\n", $output)); 
    
    try {  
        
        $result = json_decode(implode("\n", $output), true);  
        if (json_last_error() !== JSON_ERROR_NONE) {  
            throw new \Exception('JSON decode error: ' . json_last_error_msg());  
        }  

        // $result = json_decode($jsonOutput, true);  
        // if (json_last_error() !== JSON_ERROR_NONE) {  
        //     throw new \Exception('JSON decode error: ' . json_last_error_msg());  
        // }
            

        // Save evaluations to the database  
        if (isset($result['results'])) {  
            foreach ($result['results'] as $evaluationData) {  
                // Create a new evaluation record  
                Evaluation::create([  
                    'employee_id' => $evaluationData['employee_id'],  
                    'evaluation' => $evaluationData['evaluation'], 
                    'type' => 'weekly', 
                   
                ]);  
            }  
        }  
        else {  
            Log::warning('No results found in Python output.'); // Log if there are no results  
        }  

        return response()->json([  
            'status' => 'successsss',  
            'results' => $result['results'],  
        ], 200);  

    } catch (\Exception $e) {  
        Log::error('Failed to parse Python output: ' . $e->getMessage());  
        return response()->json([  
            'status' => 'error',  
            'message' => 'Failed to parse Python output',  
            // 'output' => implode("\n", $output),
            'output' => implode("\n", $output),  
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











public function daily_evaluate(Request $request)  
{  
    // Fetch points data for the last 7 days  
    $points = Points::where('created_at', '>=', now()->subDays(7))->get();  

    // Prepare an array to hold the average points per description for each employee  
    $averagePoints = [];  

    foreach ($points as $point) {  
        $employeeId = $point->employee_id;  
        $description = $point->description;  
        $pointsCount = $point->points_count;  

        // Initialize the employee in the results array if not already done  
        if (!isset($averagePoints[$employeeId])) {  
            $averagePoints[$employeeId] = [];  
        }  

        // Initialize the description in the employee's array if not already done  
        if (!isset($averagePoints[$employeeId][$description])) {  
            $averagePoints[$employeeId][$description] = [  
                'total_points' => 0,  
                'count' => 0,  
            ];  
        }  

        // Sum the points and increment the count for the description  
        $averagePoints[$employeeId][$description]['total_points'] += $pointsCount;  
        $averagePoints[$employeeId][$description]['count'] += 1;  
    }  

    // Calculate the average points for each description per employee  
    foreach ($averagePoints as $employeeId => $descriptions) {  
        foreach ($descriptions as $description => $data) {  
            if ($data['count'] > 0) {  
                $averagePoints[$employeeId][$description]['average'] = $data['total_points'] / $data['count'];  
            } else {  
                $averagePoints[$employeeId][$description]['average'] = 0;  
            }  
        }  
    }  


$payload = [];  
foreach ($averagePoints as $employeeId => $descriptions) {  
    $dataToSend = []; // Initialize an array to hold the data for each employee  

    // Iterate through all available descriptions  
    foreach ($descriptions as $description => $value) {  
        // Only include descriptions that have an 'average' value  
        if (isset($value['average'])) {  
            $dataToSend[$description] = [  $value['average']];
                // 'average' => $value['average'],  
            // ];  
        }  
    }  

    // Only add to the payload if there's at least one description with an average  
    if (!empty($dataToSend)) {  
        $payload[] = [  
            'employee_id' => $employeeId,  
            'data' => $dataToSend, // Add all descriptions with their averages  
        ];  
    }  
}  
// return $payload;

$jsonPayload = json_encode($payload);  
Log::info('JSON Payload sent to Python script:', ['jsonPayload' => $jsonPayload]);  

$tempFile = tmpfile();  
fwrite($tempFile, $jsonPayload);  
$tempFilePath = stream_get_meta_data($tempFile)['uri'];  

// Run Python script  
$pythonScript = base_path('build_fuzzy.py');  
$command = escapeshellcmd("python \"{$pythonScript}\"") . " " . escapeshellarg($tempFilePath);  

$output = [];  
$returnCode = 0;  
exec($command . " 2>&1", $output, $returnCode); // Capture both output and errors  

Log::info('Python Script Output:', ['output' => implode("\n", $output)]);  

// Handle the successful execution of the script  
if ($returnCode === 0) {  
    // Process output as before  
    try {  
        $result = json_decode(implode("\n", $output), true);  
        if (json_last_error() !== JSON_ERROR_NONE) {  
            throw new \Exception('JSON decode error: ' . json_last_error_msg());  
        }  

        // Save evaluations to the database  
        if (isset($result['results'])) {  
            foreach ($result['results'] as $evaluationData) {  
                // Create a new evaluation record  
                Evaluation::create([  
                    'employee_id' => $evaluationData['employee_id'],  
                    'evaluation' => $evaluationData['evaluation'],  
                ]);  
            }  
        }  

        return response()->json([  
            'status' => 'success',  
            'results' => $result['results'],  
        ], 200);  

    } catch (\Exception $e) {  
        Log::error('Failed to parse Python output: ' . $e->getMessage());  
        return response()->json([  
            'status' => 'error',  
            'message' => 'Failed to parse Python output',  
            'output' => implode("\n", $output),  
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


// monthly_evaluate


public function monthly_evaluate(Request $request)  
{  
    // Fetch points data for the last 7 days  
    $points = Points::where('created_at', '>=', now()->subDays(7))->get();  

    // Prepare an array to hold the average points per description for each employee  
    $averagePoints = [];  

    foreach ($points as $point) {  
        $employeeId = $point->employee_id;  
        $description = $point->description;  
        $pointsCount = $point->points_count;  

        // Initialize the employee in the results array if not already done  
        if (!isset($averagePoints[$employeeId])) {  
            $averagePoints[$employeeId] = [];  
        }  

        // Initialize the description in the employee's array if not already done  
        if (!isset($averagePoints[$employeeId][$description])) {  
            $averagePoints[$employeeId][$description] = [  
                'total_points' => 0,  
                'count' => 0,  
            ];  
        }  

        // Sum the points and increment the count for the description  
        $averagePoints[$employeeId][$description]['total_points'] += $pointsCount;  
        $averagePoints[$employeeId][$description]['count'] += 1;  
    }  

    // Calculate the average points for each description per employee  
    foreach ($averagePoints as $employeeId => $descriptions) {  
        foreach ($descriptions as $description => $data) {  
            if ($data['count'] > 0) {  
                $averagePoints[$employeeId][$description]['average'] = $data['total_points'] / $data['count'];  
            } else {  
                $averagePoints[$employeeId][$description]['average'] = 0;  
            }  
        }  
    }  


$payload = [];  
foreach ($averagePoints as $employeeId => $descriptions) {  
    $dataToSend = []; // Initialize an array to hold the data for each employee  

    // Iterate through all available descriptions  
    foreach ($descriptions as $description => $value) {  
        // Only include descriptions that have an 'average' value  
        if (isset($value['average'])) {  
            $dataToSend[$description] = [  $value['average']];
                // 'average' => $value['average'],  
            // ];  
        }  
    }  

    // Only add to the payload if there's at least one description with an average  
    if (!empty($dataToSend)) {  
        $payload[] = [  
            'employee_id' => $employeeId,  
            'data' => $dataToSend, // Add all descriptions with their averages  
        ];  
    }  
}  
// return $payload;

$jsonPayload = json_encode($payload);  
Log::info('JSON Payload sent to Python script:', ['jsonPayload' => $jsonPayload]);  

$tempFile = tmpfile();  
fwrite($tempFile, $jsonPayload);  
$tempFilePath = stream_get_meta_data($tempFile)['uri'];  

// Run Python script  
$pythonScript = base_path('build_fuzzy.py');  
$command = escapeshellcmd("python \"{$pythonScript}\"") . " " . escapeshellarg($tempFilePath);  

$output = [];  
$returnCode = 0;  
exec($command . " 2>&1", $output, $returnCode); // Capture both output and errors  

Log::info('Python Script Output:', ['output' => implode("\n", $output)]);  

// Handle the successful execution of the script  
if ($returnCode === 0) {  
    // Process output as before  
    try {  
        $result = json_decode(implode("\n", $output), true);  
        if (json_last_error() !== JSON_ERROR_NONE) {  
            throw new \Exception('JSON decode error: ' . json_last_error_msg());  
        }  

        // Save evaluations to the database  
        if (isset($result['results'])) {  
            foreach ($result['results'] as $evaluationData) {  
                // Create a new evaluation record  
                Evaluation::create([  
                    'employee_id' => $evaluationData['employee_id'],  
                    'evaluation' => $evaluationData['evaluation'],  
                ]);  
            }  
        }  

        return response()->json([  
            'status' => 'success',  
            'results' => $result['results'],  
        ], 200);  

    } catch (\Exception $e) {  
        Log::error('Failed to parse Python output: ' . $e->getMessage());  
        return response()->json([  
            'status' => 'error',  
            'message' => 'Failed to parse Python output',  
            'output' => implode("\n", $output),  
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


// for customer service 

// public function get_my_evaluation(Request $request)  
// {  
//     // Retrieve all evaluations  
//     $evaluations = Evaluation::all(); // You can also use paginate or filter as needed  
//     // $evaluations = Evaluation::where('type', 'daily')->get();  


//     // Return evaluations as JSON  
//     return response()->json($evaluations);  
// }  


public function get_my_evaluation(Request $request,) {  
    try {  
        // Sum the points for the given employee_id  
        // $pointsSum = Evaluation::where('employee_id', $request->id)
        $evaluations = Evaluation::where('employee_id', $request->id)->get();
        

        // Return evaluations as JSON  
        // return response()->json($evaluations);  
        // Build the response as an array  
        return response()->json(
            $evaluations  );  
    } catch (\Exception $e) {  
        // Handle any errors that occur during the process  
        return response()->json([  
            'status' => 'error',  
            'message' => 'An error occurred while calculating points',  
            'error' => $e->getMessage()  
        ], 500);  
    }  
}  



}  