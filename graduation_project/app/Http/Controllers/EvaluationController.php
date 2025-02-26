<?php

namespace App\Http\Controllers;
use App\Models\Points;

use Illuminate\Http\Request;

class EvaluationController extends Controller
{
    //

        // public function evaluate(Request $request)  
        // {  
        //     // Assuming you get the employee_id from the auth/user context  
        //     $employeeId = auth()->id();   
        
        //     // Fetch points for the last 7 days for all employees (or adapt to your needs)  
        //     $points = Points::where('created_at', '>=', now()->subDays(7))  
        //                    ->get();   
        
        //     // Initialize an array to hold points for each employee  
        //     $pointsByEmployee = [];  
        
        //     // Loop through the points and collate them by employee ID  
        //     foreach ($points as $point) {  
        //         // Check if the employee_id is already in the array  
        //         if (!isset($pointsByEmployee[$point->employee_id])) {  
        //             $pointsByEmployee[$point->employee_id] = []; // Initialize an array for this employee  
        //         }  
        
        //         // Add the point record to the employee's points array  
        //         $pointsByEmployee[$point->employee_id][] = [  
        //             'id' => $point->id,  
        //             'points_count' => $point->points_count,  
        //             'description' => $point->description,  
        //             'created_at' => $point->created_at,  
        //         ];  
        //     }  

            
        
        //     // Convert to a format suitable for sending to your fuzzy evaluation system  
        //     $payload = [];  
        //     foreach ($pointsByEmployee as $employeeId => $employeePoints) {  
        //         $payload[$employeeId] = [  
        //             'points' => $employeePoints, // Include all points for this employee  
        //         ];  
        //     }  

        //     return $pointsByEmployee;
        
        //     // Send points data to the Python API (adjust the URL if needed)  
        //     $response = Http::post('http://127.0.0.1:5000/evaluate', $payload);  
        
        //     // Check if the response is successful  
        //     if ($response->successful()) {  
        //         $evaluationResult = $response->json();  
        
        //         // Save the evaluation result in the database  
        //         // Here you might want to save results for each employee  
        //         foreach ($evaluationResult as $result) {  
        //             Evaluation::create([  
        //                 'employee_id' => $result['employee_id'],  // Assuming result has employee_id  
        //                 'evaluation_result' => $result['result'],  // Adjust according to your returned structure  
        //                 'created_at' => now(),  
        //             ]);  
        //         }  
        
        //         return response()->json(['success' => true, 'message' => 'Evaluations saved successfully!']);  
        //     }  
        
        //     return response()->json(['success' => false, 'message' => 'Failed to evaluate.'], 500);  
        // }  


        public function evaluate(Request $request)  
        {  
            // Fetch points for the last 7 days for all employees  
            $points = Points::where('created_at', '>=', now()->subDays(7))->get();   

            // Collate points by employee  
            $pointsByEmployee = [];  
            foreach ($points as $point) {  
                $pointsByEmployee[$point->employee_id][] = [  
                    'id' => $point->id,  
                    'points_count' => $point->points_count,  
                    'description' => $point->description,  
                    'created_at' => $point->created_at,  
                ];  
            }  

            // return $pointsByEmployee;

            // Prepare the payload for the Python script  
            $payload = json_encode($pointsByEmployee);  


            // Run the Python script with the payload passed as input  
    $command = escapeshellcmd("python build_fuzzy.py") . " " . escapeshellarg($payload);  
    $output = [];  
    $return_var = 0;  

    exec($command, $output, $return_var);  

    // Check the return status  
    if ($return_var === 0) {  
        $evaluationResult = json_decode(implode("\n", $output), true);  
        foreach ($evaluationResult as $result) {  
            Evaluation::create([  
                'employee_id' => $result['employee_id'],  
                'evaluation_result' => $result['result'],  
                'created_at' => now(),  
            ]);  
        }  
        return response()->json(['success' => true, 'message' => 'Evaluations saved successfully!']);  
    } else {  
        return response()->json(['success' => false, 'message' => 'Error executing Python script'], 500);  
    }  
}

}
        
