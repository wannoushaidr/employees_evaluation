<?php

namespace App\Http\Controllers;
use App\Models\Employees;
use App\Models\Branches;
use App\Models\Companies;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Points;


// use Illuminate\Support\Facades\Validator;



use Illuminate\Http\Request;
// to make validate for field path "app/Request/CreateEmployeeRequest"
use App\Http\Requests\CreateBranchRequest;
// to make pagination for multiple pages path"app/privders/AppServiceProvider"
use Illuminate\Pagination\Paginator;


class EmployeesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data=Employees::select('*')->orderby("id","ASC")->paginate(4);
            return view('employee.index',['data'=>$data]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $data=Employees::select('*')->orderby("id","ASC")->paginate(100);
        $data2=Branches::select('*')->orderby("id","ASC")->paginate(100);

        return view('employee.create',['data'=>$data,'data2'=>$data2]);

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //   dd($request->all());

// $datatoinsert = [];
$datatoinsert['name'] = $request->name;
$datatoinsert['number'] = $request->number;

// Handle the uploaded files
if ($request->hasFile('image')) {
    $image = $request->file('image');
    $fileName = time() . '_image.' . $image->getClientOriginalExtension();
    $image->move(public_path('uploads'), $fileName);
    $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
}

$datatoinsert['description'] = $request->description;
$datatoinsert['gender'] = $request->gender;
$datatoinsert['active'] = $request->active;
$datatoinsert['position'] = $request->position;
$datatoinsert['branch_id'] = $request->branch_id;
$datatoinsert['leader_id'] = $request->leader_id;


// Create a new Branches record
Employees::create($datatoinsert);

// Redirect with success message
return redirect()->route('employees.index')->with('success', 'employees stored successfully');


   }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=Employees::select("*")->find($id);
        $data2=Branches::select('*')->orderby("id","ASC")->paginate(100);
        $data3=Employees::select('*')->orderby("id","ASC")->paginate(100);


        return view('employee.edit',['data'=>$data,'data2'=>$data2,"data3"=>$data3]);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //        protected $fillable=['name','number','description','gender','position','image','created_at','updated_at'];
        $datatoinsert['name'] = $request->name;
        $datatoinsert['number'] = $request->number;

// Handle the uploaded files
if ($request->hasFile('image')) {
    $image = $request->file('image');
    $fileName = time() . '_image.' . $image->getClientOriginalExtension();
    $image->move(public_path('uploads'), $fileName);
    $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
}

$datatoinsert['description'] = $request->description;
$datatoinsert['gender'] = $request->gender;
$datatoinsert['position'] = $request->position;
$datatoinsert['active'] = $request->active;
$datatoinsert['branch_id'] = $request->branch_id;
$datatoinsert['leader_id'] = $request->leader_id;


// Create a new Branches record
Employees::where(['id'=>$id])->update($datatoinsert);

// Redirect with success message
return redirect()->route('employees.index')->with('success', 'employees updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Employees::where(['id'=>$id])->delete();
        return redirect()->route('employees.index')
        ->with('success','branches deleted sucessfuly');
    }


////////////////////////////////////  function for companies API ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

public function get_all_employees(){
   // $data=Employees::select('*')->orderby("id","ASC")->paginate(4);
   $data = Employees::All();
    return response()->json($data);
    // return view('branch.index',['data'=>$data]);
 }
 
//  public function set_new_employees(Request $request){
    
//     $datatoinsert['name'] = $request->name;
//     $datatoinsert['number'] = $request->number;
//     $datatoinsert['description'] = $request->description;
//     $datatoinsert['gender'] = $request->gender;
//     $datatoinsert['position'] = $request->position;
//     // $datatoinsert['leader_id'] = $request->leader_id;
//     $datatoinsert['branch_id'] = $request->branch_id;
//     if ($request->hasFile('image')) {
//         $image = $request->file('image');
//         $fileName = time() . '_image.' . $image->getClientOriginalExtension();
//         $image->move(public_path('uploads'), $fileName);
//         $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
//     }
    
//     // Check if leader_id is provided and is not the string 'null'  
//     $leaderId =  $request->leader_id; 
//     $datatoinsert['leader_id'] = ($leaderId !== 'null' && $leaderId !== null) ? $leaderId : null;  



//     $is_exsist= Employees::select("*")->where($datatoinsert)->get();
//     if(!empty($is_exsist) and count($is_exsist)>0){
//         $response=array("code"=>403,"message"=>"exists befor companies");
//     }
//     else{
//         // $datatoinsert['created_at']=date("Y-m-d H:i:s");
 
//     $flags=insert(new Employees(),$datatoinsert);
//      if ($flags){
//         $response=array("code"=>200,"message"=>"created succfully companies");
//      }
//     else{
//         $response=array("code"=>401,"message"=>"created succfully companies");
//     }
//  }
 
//     return response()->json($response);
//  }
 

//  public function update_employees(Request $request) {  
//     // Find the existing branch by ID  
//     $data = Employees::select("*")->find($request->id);  
 
//     if (!empty($data) ){  
//         // If the branch exists, prepare to update  
//       $datatoupdate['name'] = $request->name;
//     $datatoupdate['number'] = $request->number;
//     $datatoupdate['description'] = $request->description;
//     $datatoupdate['gender'] = $request->gender;
//     $datatoupdate['position'] = $request->position;
//     // $datatoinsert['leader_id'] = $request->leader_id;
//     $datatoupdate['branch_id'] = $request->branch_id;
//     if ($request->hasFile('image')) {
//         $image = $request->file('image');
//         $fileName = time() . '_image.' . $image->getClientOriginalExtension();
//         $image->move(public_path('uploads'), $fileName);
//         $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path
//     }
    
//     // Check if leader_id is provided and is not the string 'null'  
//     $leaderId =  $request->leader_id; 
//     $datatoupdate['leader_id'] = ($leaderId !== 'null' && $leaderId !== null) ? $leaderId : null;  



//           // Perform the update  
//         $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance  
//         if ($updated) {  
//             return response()->json([  
//                 'code' => 200,  
//                 'message' => 'Data updated successfully companies'  
//             ]);  
//         } else {  
//             return response()->json([  
//                 'code' => 500,  
//                 'message' => 'Failed to update data companies'  
//             ], 500);  
//         }  
//     } else {  
//         // If the branch does not exist  
//         return response()->json([  
//             'code' => 404,  
//             'message' => 'Element not found companies'  
//         ], 404);  
//     }  
 
//  }



// public function update_employees(Request $request) {
//     // Define custom error messages
//     $messages = [
//         'id.required' => 'The ID is required.',
//         'id.exists' => 'The employee does not exist.',
//         'name.required' => 'Please enter a name.',
//         'number.required' => 'Please enter a number.',
//         'description.required' => 'Please enter a description.',
//         'gender.required' => 'Please select a gender.',
//         'active.required' => 'Please select a active.',
//         'position.required' => 'Please enter a position.',
//         'branch_id.required' => 'Please select a branch.',
//         'branch_id.exists' => 'The selected branch does not exist.',
//         'image.image' => 'Please upload a valid image file.',
//         'email.email' => 'Please enter a valid email address.',  
//         'email.unique' => 'This email is already in use.', 
//     ];

//     // Validate the request data with custom messages
//     $validator = Validator::make($request->all(), [
//         'id' => 'required|exists:employees,id',
//         'name' => 'required|string|max:255',
//         'number' => 'required|numeric',
//         'description' => 'required|string',
//         'gender' => 'required|string|max:10',
//         'active' => 'required|string|max:10',
//         'position' => 'required|string|max:255',
//         'branch_id' => 'required|integer|exists:branches,id',
//         'user_id' => 'nullable|integer',
//         'email' => 'required|email|unique:users,email',  

//         // 'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048'
//     ], $messages);

//     if ($validator->fails()) {
//         // Return the validation error messages
//         return response()->json([
//             'code' => 422,
//             'message' => 'Validation error',
//             'errors' => $validator->errors()
//         ], 422);
//     }

//     // Find the existing employee by ID
//     $data = Employees::find($request->id);

//     if (!empty($data)) {
//         // If the employee exists, prepare to update
//         $datatoupdate = $request->only(['name', 'number', 'description','active', 'gender', 'position', 'branch_id']);
//         if ($request->hasFile('image')) {
//             $image = $request->file('image');
//             $fileName = time() . '_image.' . $image->getClientOriginalExtension();
//             $image->move(public_path('uploads'), $fileName);
//             $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path
//         }

//         // Check if leader_id is provided and is not the string 'null'
//         $leaderId = $request->leader_id;
//         $datatoupdate['leader_id'] = ($leaderId !== 'null' && $leaderId !== null) ? $leaderId : null;

//         // Perform the update
//         $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance
//         if ($updated) {
//             return response()->json([
//                 'code' => 200,
//                 'message' => 'Employee updated successfully'
//             ]);
//         } else {
//             return response()->json([
//                 'code' => 500,
//                 'message' => 'Failed to update employee'
//             ], 500);
//         }
//     } else {
//         // If the employee does not exist
//         return response()->json([
//             'code' => 404,
//             'message' => 'Employee not found'
//         ], 404);
//     }
// }


public function update_employees(Request $request) {  
    // Define custom error messages  
  //  return response()->json($request);
    $messages = [  
        'id.required' => 'The ID is required.',  
        'id.exists' => 'The employee does not exist.',  
        'name.required' => 'Please enter a name.',  
        'number.required' => 'Please enter a number.',  
        'description.required' => 'Please enter a description.',  
        'gender.required' => 'Please select a gender.',  
        'active.required' => 'Please select an active status.',  
        'position.required' => 'Please enter a position.',  
        'branch_id.required' => 'Please select a branch.',  
        'branch_id.exists' => 'The selected branch does not exist.',  
        'image.image' => 'Please upload a valid image file.',  
        'email.email' => 'Please enter a valid email address.',  
        'email.unique' => 'This email is already in use.',   
    ];  

    // Validate the request data with custom messages  
    $validator = Validator::make($request->all(), [  
        'id' => 'required|exists:employees,id',  
        'name' => 'required|string|max:255',  
        'number' => 'required|numeric',  
        'description' => 'required|string',  
        'gender' => 'required|string|max:10',  
        'active' => 'required|string|max:10',  
        'position' => 'required|string|max:255',  
        'branch_id' => 'required|integer|exists:branches,id',  
       //   'user_id' => 'nullable|exists:users,id', // Ensure user_id exists in users table  
        'email' => 'required|email' ,  // Allow existing email for the user being updated  
    ], $messages);  

    if ($validator->fails()) {  
        // Return the validation error messages  
        return response()->json([  
            'code' => 422,  
            'message' => 'Validation error',  
            'errors' => $validator->errors()  
        ], 422);  
    }  

    // Find the existing employee by ID  
    $data = Employees::find($request->id);  

//return response()->json($data);
        // If the employee exists, prepare to update  
        $datatoupdate = $request->only(['name', 'number', 'description', 'active', 'gender', 'position', 'branch_id','email']);  




        // Check if an image is uploaded  
        if ($request->hasFile('image')) {  
            $image = $request->file('image');  
            $fileName = time() . '_image.' . $image->getClientOriginalExtension();  
            // $image->move(public_path('uploads'), $fileName);  
            // $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path  
            $image->move('C:/Users/LENOVO/AndroidStudioProjects/employees_evaluation/clothes_store/assets/images/', $fileName);
       
            $imagepath = 'assets/images/' . $fileName;
            $datatoupdate['image'] = $imagepath;
        }  


        // Check if leader_id is provided and is not the string 'null'  
        $leaderId = $request->leader_id;  
        $datatoupdate['leader_id'] = ($leaderId !== 'null' && $leaderId !== null) ? $leaderId : null;  

        // Perform the update on the employee  
        $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance  

        // Update the associated user's email if user_id is provided  
        if ($request->user_id) {  
            $user = User::find($request->user_id);  
            if ($user) {  
                $user->email = $request->email;  // Update the user's email  
                $user->save();  // Save the user record  
            }  
        }  

        if ($updated) {  
            return response()->json([  
                'code' => 200,  
                'message' => 'Employee updated successfully'  
            ]);  
        } else {  
            return response()->json([  
                'code' => 500,  
                'message' => 'Failed to update employee'  
            ], 500);  
        }  
    
}
















public function set_new_employees(Request $request){
    // Define custom error messages
    //return response()->json($data);

    $messages = [
        'name.required' => 'Please enter a name.',
        'number.required' => 'Please enter a number.',
        'description.required' => 'Please enter a description.',
        'gender.required' => 'Please select a gender.',
        'active.required' => 'Please select a active.',
        'position.required' => 'Please enter a position.',
        'branch_id.required' => 'Please select a branch.',
        'branch_id.exists' => 'The selected branch does not exist.',
        'image.image' => 'Please upload a valid image file.',
        // 'leader_id.exists' => 'The selected leader does not exist.',
        'email.required' => 'Please enter an email address.',  
        'email.email' => 'Please enter a valid email address.',  
        'email.unique' => 'This email is already in use.',  
        // 'password.required' => 'Please enter a password.',  
        // 'password.min' => 'The password must be at least 8 characters.',  
    ];

    // Validate the request data with custom messages
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|max:255',
        'number' => 'required|string|max:255',
        'description' => 'required|string',
        'gender' => 'required|string|max:10',
        'active' => 'required|string|max:10',
        'position' => 'required|string|max:255',
        'branch_id' => 'required|integer|exists:branches,id',
        'image' => 'required|image|mimes:jpeg,png,jpg,gif',
        'leader_id' => 'nullable|integer|exists:employees,id','unique:employees', // Adding validation for leader_id
        'email' => 'required|email|unique:users',  
        // 'user_id' => 'integer',
        // 'password' => 'required|string|min:8',
    ], $messages);

    if ($validator->fails()) {
        // Return the validation error messages
        return response()->json([
            'code' => 422,
            'message' => 'Validation error',
            'errors' => $validator->errors()
        ], 422);
    }

    // Prepare the data for insertion
    $datatoinsert = $request->only(['name', 'number', 'description','active', 'gender', 'position', 'branch_id', 'leader_id','user_id','email']);
    if ($request->hasFile('image')) {
        $image = $request->file('image');
        $fileName = time() . '_image.' . $image->getClientOriginalExtension();
        // $image->move(public_path('uploads'), $fileName);
        // $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
        $image->move('C:/Users/LENOVO/AndroidStudioProjects/employees_evaluation/clothes_store/assets/images/', $fileName);
            $imagepath = 'assets/images/' . $fileName;
            $datatoinsert['image'] = $imagepath;
    }

    $is_exsist = Employees::where($datatoinsert)->get();
    if ($is_exsist->isNotEmpty()) {
        $response = ["code" => 403, "message" => "Employee already exists"];
    } else {
        $datatoinsert['created_at'] = now();
        $employee = Employees::create($datatoinsert); // Assuming Employees model is fillable
        // $image = $request->file('image');
        // $fileName = time() . '_image.' . $image->getClientOriginalExtension();
        // $image->move(public_path('uploads'), $fileName);
        // $imagepath = 'uploads/' . $fileName;
        $user = User::create([
            'name' => $request->name,  
            'email'=>$request->email,
            'password' => Hash::make('12345678'), // Hash the password  
            'role' => $request->position, // Default role, adjust as needed 
            'image' => $datatoinsert['image'], // Default role, adjust as needed 

        ]);
        // Associate the created user with the new employee  
            $employee->user_id = $user->id; // Assign the new user ID to the employee  
            $employee->save(); // Save the employee record with the new user ID  

            return response()->json(["code" => 200, "message" => "Employee and user created successfully"]);  
    }

    return response()->json($response);
}


// public function delete_employees(Request $request)
// {
//    $data = Employees::select("*")->find($request->id);  

//    if(!empty($data)){
//        Employees::where(['id'=>$request->id])->delete();
//        return response()->json([  
//            'code' => 200,  
//            'message' => 'Element deleted companies'  
//        ], 200);

//    }
//    else{  
       
//        return response()->json([  
//            'code' => 404,  
//            'message' => 'Element not found companies'  
//        ], 404);  
   

//    }

// }

public function delete_employees(Request $request)  
{  
    // Find the employee record based on the provided ID  
    $employee = Employees::select("*")->find($request->id);  

    // Check if the employee record exists  
    if (!empty($employee)) {  
        // Get the user_id of the employee to delete the corresponding user record  
        $userId = $employee->user_id;  

        // Delete the employee record  
        Employees::where(['id' => $request->id])->delete();  

        // Check if the user_id is not null before attempting to delete the user  
        if ($userId) {  
            // Delete the corresponding user record  
            User::where(['id' => $userId])->delete();  
        }  

        // Return a success response  
        return response()->json([  
            'code' => 200,  
            'message' => 'Employee and associated user deleted successfully'  
        ], 200);  
    } else {  
        // Return a response indicating that the employee was not found  
        return response()->json([  
            'code' => 404,  
            'message' => 'Employee not found'  
        ], 404);  
    }  
}





public function get_my_information(Request $request)
{
    if ($request->has('id')) {
        $id = $request->input('id');
        // Retrieve the employee where employee_id matches the given id
        $employee = Employees::find($id);

        if (!$employee) {
            return response()->json(['message' => 'Employee not found'], 404);
        }

        // Initialize response data
        $data = [
            'employee' => $employee,
            'supervisor' => null,
            'manager' => null
        ];

        // Check employee's position and set leader/manager accordingly
        if ($employee->position == 'customer_service') {
            // Customer service has both a supervisor and a manager
            $supervisor = Employees::find($employee->leader_id);
            $manager = Employees::find($supervisor->leader_id ?? null);
            $data['supervisor'] = [
                'id' => $supervisor->id ?? null,
                'name' => $supervisor->name ?? null,
            ];
            $data['manager'] = [
                'id' => $manager->id ?? null,
                'name' => $manager->name ?? null,
            ];
        } elseif ($employee->position == 'supervisor') {
            // Supervisor has only a manager
            $manager = Employees::find($employee->leader_id);
            $data['manager'] = [
                'id' => $manager->id ?? null,
                'name' => $manager->name ?? null,
            ];
        }

        return response()->json($data);
    } else {
        // If no id is provided, return an error
        return response()->json(['message' => 'No ID provided'], 400);
    }
}




public function get_my_activativate_employee(Request $request, $id)  
{  
    // Check if an ID is provided  
    if (!$id) {  
        return response()->json(['error' => 'No ID provided'], 400);  
    }  

    // Initialize an array to hold the results  
    $results = [];  

    // Find the employee based on the provided ID  
    $employee = Employees::find($id);  

    if (!$employee) {  
        return response()->json(['error' => 'No employee found with the provided ID'], 404);  
    }  

    // Check if the ID corresponds to a manager or a supervisor  
    // If the employee is a manager, get their supervisors  
    if ($employee->position === 'manager') {  
        // Retrieve all supervisors under the manager  
        $supervisors = Employees::where('leader_id', $employee->id)  
                                 ->where('position', 'supervisor')  
                                 ->get();  
    } else {  
        // If it's a supervisor, create a collection with this supervisor for employee retrieval   
        $supervisors = collect([$employee]);  
    }  

    // For each supervisor, retrieve their respective employees  
    foreach ($supervisors as $supervisor) {  
        $employees = Employees::where('leader_id', $supervisor->id)->get();  
        foreach ($employees as $employee) {  
            // Check if the employee is active  
            if ($employee->active=='true') {  
                $results[] = [  
                    'id' => $employee->id,  
                    'name' => $employee->name,  
                    'description' => $employee->description,  
                    'number' => $employee->number,  
                    'gender' => $employee->gender,  
                    'position' => $employee->position,  
                    'active' => $employee->active,  
                    'leader_id' => $employee->leader_id,  
                    'user_id' => $employee->user_id,  
                    'image' => $employee->image,  
                    'branch_id' => $employee->branch_id,  
                    'created_at' => $employee->created_at,  
                    'updated_at' => $employee->updated_at,  
                ];  
            }  
        }  
    }  

    // Return the result as a JSON response  
    return response()->json(array_values($results));  
}




public function get_my_employees_information(Request $request, $id)  
{  
    if ($id) {  
        $managerId = $id;  

        // Initialize an array to hold the results  
        $results = [];  

        // Retrieve manager data and add it to results  
        $manager = Employees::find($managerId);  
        
        // If the manager exists, store their data in the results array  
        // but do not include them in the final output.  
        if ($manager) {  
            // You can still keep this data for logging or other purposes if needed  
            $managerData = [  
                'id' => $manager->id,  
                'name' => $manager->name,  
                'description' => $manager->description,  
                'number' => $manager->number,  
                'gender' => $manager->gender,  
                'position' => $manager->position,  
                'active' => $manager->active,  
                'leader_id' => $manager->leader_id,  
                'image' => $manager->image,  
                'branch_id' => $manager->branch_id,  
                'user_id' => $manager->user_id,  
                'created_at' => $manager->created_at,  
                'updated_at' => $manager->updated_at,  
            ];  
        }  

        // Retrieve all supervisors under the manager  
        $supervisors = Employees::where('leader_id', $managerId)  
                                ->where('position', 'supervisor')  
                                ->get();  

        // For each supervisor, retrieve their respective employees and add to results  
        foreach ($supervisors as $supervisor) {  
            $results[] = [  
                'id' => $supervisor->id, // Keep supervisor's ID  
                'name' => $supervisor->name,  
                'description' => $supervisor->description,  
                'number' => $supervisor->number,  
                'gender' => $supervisor->gender,  
                'position' => $supervisor->position,  
                'active' => $supervisor->active,  
                'leader_id' => $supervisor->leader_id,  
                'image' => $supervisor->image,  
                'branch_id' => $supervisor->branch_id,  
                'user_id' => $manager->user_id,
                'created_at' => $supervisor->created_at,  
                'updated_at' => $supervisor->updated_at,  
            ];  

            // Retrieve employees for each supervisor  
            $employees = Employees::where('leader_id', $supervisor->id)->get();  
            foreach ($employees as $employee) {  
                $results[] = [  
                    'id' => $employee->id,  // Keep the employee's ID  
                    'name' => $employee->name,  
                    'description' => $employee->description,  
                    'number' => $employee->number,  
                    'gender' => $employee->gender,  
                    'position' => $employee->position,  
                    'active' => $employee->active,  
                    'leader_id' => $employee->leader_id,  
                    'user_id' => $employee->user_id,
                    'image' => $employee->image,  
                    'branch_id' => $employee->branch_id,  
                    'created_at' => $employee->created_at,  
                    'updated_at' => $employee->updated_at,  
                ];  
            }  
        }  

        // Retrieve customer service employees directly under the manager  
        $customerService = Employees::where('leader_id', $managerId)  
                                   ->where('position', 'customer_service')  
                                   ->get();  

        // Add customer service employees to results  
        foreach ($customerService as $customer) {  
            $results[] = [  
                'id' => $customer->id,  // Keep customer service employee's ID  
                'name' => $customer->name,  
                'description' => $customer->description,  
                'number' => $customer->number,  
                'gender' => $customer->gender,  
                'position' => $customer->position,  
                'active' => $customer->active,  
                'leader_id' => $customer->leader_id,  
                'image' => $customer->image,  
                'user_id' => $customer->user_id,
                'branch_id' => $customer->branch_id,  
                'created_at' => $customer->created_at,  
                'updated_at' => $customer->updated_at,  
            ];  
        }  

        // Filter out the manager's ID from the results  
        $filteredResults = array_filter($results, function($employee) use ($managerId) {  
            return $employee['id'] !== $managerId; // Exclude employee with manager's ID  
        });  

        // Return the filtered results as a flat array   
        return response()->json(array_values($filteredResults));  
    } else {  
        // If no ID is provided, return an error  
        return response()->json(['error' => 'No ID provided'], 400);  
    }  
}








public function get_employees_count() {
    try {
        // Initialize employee counts
        $employeeCount = 0;
        $customerServiceCount = 0;
        $managerCount = 0;
        $supervisorCount = 0;

        // Get all branches
        $branches = Branches::all();

        // Loop through each branch and count the employees by position
        foreach ($branches as $branch) {
            $branchEmployees = Employees::where('branch_id', $branch->id)->get();
            foreach ($branchEmployees as $employee) {
                $employeeCount++;
                switch ($employee->position) {
                    case 'customer_service':
                        $customerServiceCount++;
                        break;
                    case 'manager':
                        $managerCount++;
                        break;
                    case 'supervisor':
                        $supervisorCount++;
                        break;
                }
            }
        }

        return response()->json([
            'employee_count' => $employeeCount,
            'customer_service_count' => $customerServiceCount,
            'manager_count' => $managerCount,
            'supervisor_count' => $supervisorCount
        ]);
    } catch (\Exception $e) {
        // Log the error for debugging purposes
        \Log::error('Error fetching employee count: ' . $e->getMessage());

        // Return a generic error response
        return response()->json(['error' => 'An error occurred while fetching the employee count.'], 500);
    }
}


public function getSupervisorsAndCustomerServiceEmployees(Request $request,$id) {
    if($id){
    try {
        // Initialize employee counts
        $employeeCount = 0;
        $customerServiceCount = 0;  
        $supervisorCount = 0;

        // Get the supervisors under the given manager
        $supervisors = Employees::where('leader_id', $request->id)
                                ->where('position', 'supervisor')
                                ->get();

        // Loop through each supervisor and count the employees by position
        foreach ($supervisors as $supervisor) {
            $supervisorCount++;
            $employeeCount++;
            $supervisorEmployees = Employees::where('leader_id', $supervisor->id)->get();
            foreach ($supervisorEmployees as $employee) {
                $employeeCount++;
                if ($employee->position == 'customer_service') {
                    $customerServiceCount++;
                }
            }
        }

        return response()->json([
            'employee_count' => $employeeCount,
            'customer_service_count' => $customerServiceCount,
            'supervisor_count' => $supervisorCount
        ]);
    } catch (\Exception $e) {
        // Log the error for debugging purposes
        \Log::error('Error fetching employee count: ' . $e->getMessage());

        // Return a generic error response
        return response()->json(['error' => 'An error occurred while fetching the employee count.'], 500);
    }
}
}


// public function getCustomerServiceEmployeesCount(Request $request,$id) {
//     if($id){
//     try {
//         // Initialize employee counts
//         $employeeCount = 0;
//         $customerServiceCount = 0;


//         // Loop through each supervisor and count the employees by position
        
//             $supervisorEmployees = Employees::where('leader_id', $request->id)->get();
//             foreach ($supervisorEmployees as $employee) {
//                 $employeeCount++;
//                 if ($employee->position == 'customer_service') {
//                     $customerServiceCount++;
//                     $employeeCount++;
//                 }
//             }

//         return response()->json([
//             'employee_count' => $employeeCount,
//             'customer_service_count' => $customerServiceCount,
//         ]);
//     } catch (\Exception $e) {
//         // Log the error for debugging purposes
//         \Log::error('Error fetching employee count: ' . $e->getMessage());

//         // Return a generic error response
//         return response()->json(['error' => 'An error occurred while fetching the employee count.'], 500);
//     }
// }
// }




// public function getCustomerServiceEmployeesCount(Request $request,$id) {
//     if($id){
//     try {
//         // Initialize employee counts
//         $employeeCount = 0;
//         $customerServiceCount = 0;


//         // Loop through each supervisor and count the employees by position
        
//             $supervisorEmployees = Employees::where('leader_id', $request->id)->get();
//             foreach ($supervisorEmployees as $employee) {
//                 $employeeCount++;
//                 if ($employee->position == 'customer_service') {
//                     $customerServiceCount++;
//                     $employeeCount++;
//                 }
//             }

//         return response()->json([
//             'employee_count' => $employeeCount,
//             'customer_service_count' => $customerServiceCount,
//         ]);
//     } catch (\Exception $e) {
//         // Log the error for debugging purposes
//         \Log::error('Error fetching employee count: ' . $e->getMessage());

//         // Return a generic error response
//         return response()->json(['error' => 'An error occurred while fetching the employee count.'], 500);
//     }
// }
// }


public function getCustomerServiceEmployeesCount(Request $request, $id) {  
    if ($id) {  
        try {  
            // Initialize employee counts and total points  
            $employeeCount = 0;  
            $customerServiceCount = 0;  
            $totalPoints = 0;  

            // Get supervisor's employees  
            $supervisorEmployees = Employees::where('leader_id', $id)->get();  

            foreach ($supervisorEmployees as $employee) {  
                $employeeCount++; // Count every employee  

                // Check if the employee is in customer service  
                if ($employee->position == 'customer_service') {  
                    $customerServiceCount++; // Increment customer service count  

                    // Assuming the employee has a relationship to the Point model  
                    // and each employee can have multiple points records  
                    // Sum the points for customer service employees  
                    $employeePoints = Points::where('employee_id', $employee->id) // Adjust the column to match your schema  
                                           ->sum('points_count'); // Sum points_count from Points table  
                    $totalPoints += $employeePoints; // Add to total points  
                }  
            }  

            return response()->json([  
                // 'employee_count' => $employeeCount,  
                'customer_service_count' => $customerServiceCount,  
                'total_points' => $totalPoints, // Include total points in the response  
            ]);  
        } catch (\Exception $e) {  
            // Log the error for debugging purposes  
            \Log::error('Error fetching employee count: ' . $e->getMessage());  

            // Return a generic error response  
            return response()->json(['error' => 'An error occurred while fetching the employee count.'], 500);  
        }  
    }  
}












// to update cutomer_service active value  when strt service new cutmer
public function update_customer_service_active(Request $request) {
    // Validate the request data
    $validator = Validator::make($request->all(), [
        'id' => 'required|exists:employees,id',
        'active' => 'required|string|max:255',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'code' => 422,
            'message' => 'Validation error',
            'errors' => $validator->errors()
        ], 422);
    }

    // Find the existing employee by ID
    $employee = Employees::find($request->id);

    if ($employee) {
        // Update only the position
        $employee->active = $request->active;
        $employee->save();

        return response()->json([
            'code' => 200,
            'message' => 'Employee active updated successfully'
        ]);
    } else {
        return response()->json([
            'code' => 404,
            'message' => 'Employee not found'
        ], 404);
    }
}


// // to get tstatistic for customer_service
// public function get_statistic(Request $request) {
//     try {
//         // Sum the points for the given employee_id
//         $pointsSum = Points::where('employee_id', $request->id)->sum('points_count');
        
//         return response()->json([
            
//             'employee_count' => 5,
//             'points_sum' => $pointsSum,
//             'evaluation'=>"good"
//         ], 200);
//     } catch (\Exception $e) {
//         // Handle any errors that occur during the process
//         return response()->json([
//             'status' => 'error',
//             'message' => 'An error occurred while calculating points',
//             'error' => $e->getMessage()
//         ], 500);
//     }
// }

// public function get_statistic($id) {  
//     try {  
//         // Sum the points for the given employee_id  
//         $pointsSum = Points::where('employee_id', $id)->sum('points_count');  

//         // Build the response as an array  
//         return response()->json([  
        
//                 'employee_count' => 5,  
//                 'points_sum' => $pointsSum,  
//                 'evaluation' => "good"  
            
//         ]);  
//     } catch (\Exception $e) {  
//         // Handle any errors that occur during the process  
//         return response()->json([  
//             'status' => 'error',  
//             'message' => 'An error occurred while calculating points',  
//             'error' => $e->getMessage()  
//         ], 500);  
//     }  
// }

// for servi e cutomer
public function get_statistic($id) {  
    try {  
        // Sum the points for the given employee_id  
        $pointsSum = Points::where('employee_id', $id)->sum('points_count');  

        // Build the response as an array  
        return response()->json([  
            'employee_count' => 5,  // Static value for demonstration  
            'points_sum' => $pointsSum,  
            'evaluation' => "good"  
        ]);  
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
