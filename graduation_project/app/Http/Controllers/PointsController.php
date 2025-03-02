<?php

namespace App\Http\Controllers;

use App\Models\Points;
use Illuminate\Http\Request;
use App\Models\Employees;
use Illuminate\Support\Facades\Validator;


class PointsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data=Points::select('*')->orderby("id","ASC")->paginate(4);
            return view('point.index',['data'=>$data]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    
    {
        $data=Points::select('*')->orderby("id","ASC")->paginate(100);
        $data2=Employees::select('*')->orderby("id","ASC")->paginate(100);


        return view('point.create',['data'=>$data,'data2'=>$data2]);

        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $datatoinsert['points_count'] = $request->points_count;
        $datatoinsert['description'] = $request->description;
        $datatoinsert['employee_id'] = $request->employee_id;
        $datatoinsert['customer_id'] = $request->customer_id;

        // Create a new Branches record
        Points::create($datatoinsert);

        // Redirect with success message
        return redirect()->route('points.index')->with('success', 'employees stored successfully');



    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function show(Points $points)
    {
        
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=Points::select("*")->find($id);
        $data2=Employees::select('*')->orderby("id","ASC")->paginate(100);


        return view('point.edit',['data'=>$data,'data2'=>$data2]);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $datatoinsert['points_count'] = $request->points_count;
        $datatoinsert['description'] = $request->description;
        $datatoinsert['employee_id'] = $request->employee_id;
        Points::where(['id'=>$id])->update($datatoinsert);


        // Redirect with success message
        return redirect()->route('points.index')->with('success', 'points updated successfully');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Points::where(['id'=>$id])->delete();
        return redirect()->route('points.index');
    }






// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// fot api //////////////////////////////////////////////////////////////////////////////////////////



public function get_all_points(Request $request){
    // $data = Points::All();
    // return response()->json($data);
    $data = Points::select('*')->orderby("id", "ASC")->paginate(100);
    return response()->json($data);
}

public function get_all_points_for_evaluation(Request $request){
    $data = Points::All();
    // return response()->json($data);
    // $data = Points::select('*')->orderby("id", "ASC")->paginate(100);
    return response()->json($data);
}



// public function get_employee_points(Request $request) {
//     try {
//         if ($request->has('id')) {
//             $id = $request->input('id');
//             // Retrieve the employee's position
//             $employee = Employees::find($id);
//             if (!$employee) {
//                 return response()->json(['error' => 'We don’t have this ID'], 404);
//             } elseif ($employee->position != 'customer_service') {
//                 return response()->json(['error' => 'This ID is not customer service'], 403);
//             } else {
//                 // Retrieve points where employee_id matches the given id
//                 $data = Points::where('employee_id', $id)->paginate();
//                 if ($data->isEmpty()) {
//                     return response()->json(['error' => 'This employee doesn’t have points'], 404);
//                 }
//             }
//         } else {
//             return response()->json(['error' => 'ID is required'], 400);
//         }

//         return response()->json($data);
//     } catch (\Exception $e) {
//         return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
//     }
// }


public function get_employee_points(Request $request) {  
    try {  
        if ($request->has('id')) {  
            $id = $request->input('id');  
            // Retrieve the employee's position  
            $employee = Employees::find($id);  
            if (!$employee) {  
                return response()->json(['error' => 'We don’t have this ID'], 404);  
            } elseif ($employee->position != 'customer_service') {  
                return response()->json(['error' => 'This ID is not customer service'], 403);  
            } else {  
                // Retrieve all points where employee_id matches the given id  
                $data = Points::where('employee_id', $id)->get();  

                if ($data->isEmpty()) {  
                    return response()->json(['error' => 'This employee doesn’t have points'], 404);  
                }  
                
                // Return all point records for the employee  
                return response()->json($data); // Return the entire collection  
            }  
        } else {  
            return response()->json(['error' => 'ID is required'], 400);  
        }  
    } catch (\Exception $e) {  
        return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);  
    }  
}



// public function set_new_points(Request $request){
//     $datatoinsert['points_count'] = $request->points_count;
//     $datatoinsert['description'] = $request->description;
//     $datatoinsert['employee_id'] = $request->employee_id;
//     $is_exsist = Points::select("*")->where($datatoinsert)->get();
    
//     if (!empty($is_exsist) && count($is_exsist) > 0) {
//         $response = array("code" => 403, "message" => "exists before Points");
//     } else {
//         $datatoinsert['created_at'] = date("Y-m-d H:i:s");
//         Points::create($datatoinsert);
        
//         if ($datatoinsert) {
//             $response = array("code" => 200, "message" => "created successfully Points");
//         } else {
//             $response = array("code" => 401, "message" => "failed to create Points");
//         }
//     }

//     return response()->json($response);
// }

public function set_new_points(Request $request){
    // Define custom error messages
    $messages = [
        'points_count.required' => 'Please enter the points count.',
        'points_count.integer' => 'The points count must be an integer.',
        'description.required' => 'Please enter a description.',
        'employee_id.required' => 'Please select an employee.',
        'employee_id.exists' => 'The selected employee does not exist.',
    ];

    // Validate the request data with custom messages
    $validator = Validator::make($request->all(), [
        'points_count' => 'required|integer',
        'description' => 'required|string|max:255',
        'employee_id' => 'required|exists:employees,id',
    ], $messages);

    if ($validator->fails()) {
        // Return the validation error messages
        return response()->json([
            'code' => 422,
            'message' => 'Validation error',
            'errors' => $validator->errors()
        ], 422);
    }

    $datatoinsert['points_count'] = $request->points_count;
    $datatoinsert['description'] = $request->description;
    $datatoinsert['employee_id'] = $request->employee_id;
    $datatoinsert['customer_id'] = $request->customer_id;
    $datatoinsert['created_at'] = date("Y-m-d H:i:s");
    $points = Points::create($datatoinsert);
    if ($points) { 
        $response = array("code" => 200, "message" => "created successfully Points"); 
    } else { 
        $response = array("code" => 401, "message" => "failed to create Points");
    }
    return response()->json($response);
}






// public function update_points(Request $request) {
//     $data = Points::select("*")->find($request->id);
    
//     if (!empty($data)) {
//         $datatoupdate = []; 
//         $datatoupdate['points_count'] = $request->points_count;
//         $datatoupdate['description'] = $request->description;
//         $datatoupdate['employee_id'] = $request->employee_id;
        
//         $updated = $data->update($datatoupdate); 
        
//         if ($updated) {
//             return response()->json([
//                 'code' => 200,
//                 'message' => 'Data updated successfully Points'
//             ]);
//         } else {
//             return response()->json([
//                 'code' => 500,
//                 'message' => 'Failed to update data Points'
//             ], 500);
//         }
//     } else {
//         return response()->json([
//             'code' => 404,
//             'message' => 'Element not found Points'
//         ], 404);
//     }
// }

public function delete_points(Request $request)
{
    $data = Points::select("*")->find($request->id);  

    if (!empty($data)) {
        Points::where(['id' => $request->id])->delete();
        return response()->json([  
            'code' => 200,  
            'message' => 'Element deleted Points'  
        ], 200);
    } else {
        return response()->json([  
            'code' => 404,  
            'message' => 'Element not found Points'  
        ], 404);  
    }
}




// public function get_my_employee_points(Request $request)
// {
//     if ($request->has('id')) {
//         $id = $request->input('id');

//         // Retrieve the employee with the given id
//         $employee = Employees::find($id);

//         if (!$employee) {
//             return response()->json(['error' => 'Employee not found'], 404);
//         }

//         $data = [];

//         // Check the employee's position
//         if ($employee->position == 'manager') {
//             // Manager: Get all supervisors under this manager and their customer service employees
//             $supervisors = Employees::where('leader_id', $employee->id)
//                                    ->where('position', 'supervisor')
//                                    ->get();

//             foreach ($supervisors as $supervisor) {
//                 $customerServices = Employees::where('leader_id', $supervisor->id)
//                                             ->where('position', 'customer_service')
//                                             ->get();

//                 foreach ($customerServices as $customerService) {
//                     $points = Points::where('employee_id', $customerService->id)->get();
//                     $data[] = [
//                         'supervisor' => $supervisor,
//                         'employee' => $customerService,
//                         'points' => $points
//                     ];
//                 }
//             }
//         } elseif ($employee->position == 'supervisor') {
//             // Supervisor: Get all customer service employees under this supervisor
//             $customerServices = Employees::where('leader_id', $employee->id)
//                                         ->where('position', 'customer_service')
//                                         ->get();

//             foreach ($customerServices as $customerService) {
//                 $points = Points::where('employee_id', $customerService->id)->get();
//                 $data[] = [
//                     'employee' => $customerService,
//                     'points' => $points
//                 ];
//             }
//         } else {
//             // If the employee is neither a manager nor a supervisor, return an error
//             return response()->json(['error' => 'Invalid employee position (this is service cusomer id'], 400);
//         }

//         return response()->json($data);
//     } else {
//         // If no id is provided, return an error
//         return response()->json(['error' => 'No ID provided'], 400);
//     }
// }


// public function get_my_employee_points(Request $request)
// {
//     if ($request->has('id')) {
//         $id = $request->input('id');

//         // Retrieve the employee with the given id
//         $employee = Employees::find($id);

//         if (!$employee) {
//             return response()->json(['error' => 'Employee not found'], 404);
//         }

//         $data = [];

//         // Check the employee's position
//         if ($employee->position == 'manager') {
//             // Manager: Get all supervisors under this manager and their customer service employees
//             $supervisors = Employees::where('leader_id', $employee->id)
//                                    ->where('position', 'supervisor')
//                                    ->get();

//             foreach ($supervisors as $supervisor) {
//                 $customerServices = Employees::where('leader_id', $supervisor->id)
//                                             ->where('position', 'customer_service')
//                                             ->get();

//                 foreach ($customerServices as $customerService) {
//                     $points = Points::where('employee_id', $customerService->id)->get();
//                     $data[] = [
//                         // 'supervisor' => $supervisor,
//                         // 'employee' => $customerService,
//                         'points' => $points
//                     ];
//                 }
//             }
//         } elseif ($employee->position == 'supervisor') {
//             // Supervisor: Get all customer service employees under this supervisor
//             $customerServices = Employees::where('leader_id', $employee->id)
//                                         ->where('position', 'customer_service')
//                                         ->get();

//             foreach ($customerServices as $customerService) {
//                 $points = Points::where('employee_id', $customerService->id)->get();
//                 $data[] = [
//                     // 'employee' => $customerService,
//                     'points' => $points
//                 ];
//             }
//         } else {
//             // If the employee is neither a manager nor a supervisor, return an error
//             return response()->json(['error' => 'Invalid employee position (this is service cusomer id'], 400);
//         }

//         return response()->json($data);
//     } else {
//         // If no id is provided, return an error
//         return response()->json(['error' => 'No ID provided'], 400);
//     }
// }


public function get_my_employee_points(Request $request)  
{  
    if ($request->has('id')) {  
        $id = $request->input('id');  

        // Retrieve the employee with the given id  
        $employee = Employees::find($id);  

        if (!$employee) {  
            return response()->json(['error' => 'Employee not found'], 404);  
        }  

        $pointsData = []; // Use this array to collect all points  

        // Check the employee's position  
        if ($employee->position == 'manager') {  
            // Manager: Get all supervisors under this manager and their customer service employees  
            $supervisors = Employees::where('leader_id', $employee->id)  
                                   ->where('position', 'supervisor')  
                                   ->get();  

            foreach ($supervisors as $supervisor) {  
                $customerServices = Employees::where('leader_id', $supervisor->id)  
                                            ->where('position', 'customer_service')  
                                            ->get();  

                foreach ($customerServices as $customerService) {  
                    $points = Points::where('employee_id', $customerService->id)->get();  
                    $pointsData = array_merge($pointsData, $points->toArray()); // Merge points  
                }  
            }  
        } elseif ($employee->position == 'supervisor') {  
            // Supervisor: Get all customer service employees under this supervisor  
            $customerServices = Employees::where('leader_id', $employee->id)  
                                        ->where('position', 'customer_service')  
                                        ->get();  

            foreach ($customerServices as $customerService) {  
                $points = Points::where('employee_id', $customerService->id)->get();  
                $pointsData = array_merge($pointsData, $points->toArray()); // Merge points  
            }  
        } else {  
            // If the employee is neither a manager nor a supervisor, return an error  
            return response()->json(['error' => 'Invalid employee position'], 400);  
        }  

        return response()->json($pointsData); // Directly return the points data array  
    } else {  
        // If no id is provided, return an error  
        return response()->json(['error' => 'No ID provided'], 400);  
    }  
}




}
