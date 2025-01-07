<?php

namespace App\Http\Controllers;
use App\Models\Employees;
use App\Models\Branches;
use Illuminate\Support\Facades\Validator;



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



public function update_employees(Request $request) {
    // Define custom error messages
    $messages = [
        'id.required' => 'The ID is required.',
        'id.exists' => 'The employee does not exist.',
        'name.required' => 'Please enter a name.',
        'number.required' => 'Please enter a number.',
        'description.required' => 'Please enter a description.',
        'gender.required' => 'Please select a gender.',
        'position.required' => 'Please enter a position.',
        'branch_id.required' => 'Please select a branch.',
        'branch_id.exists' => 'The selected branch does not exist.',
        'image.image' => 'Please upload a valid image file.',
    ];

    // Validate the request data with custom messages
    $validator = Validator::make($request->all(), [
        'id' => 'required|exists:employees,id',
        'name' => 'required|string|max:255',
        // 'number' => 'required|numeric',
        // 'description' => 'required|string',
        // 'gender' => 'required|string|max:10',
        // 'position' => 'required|string|max:255',
        // 'branch_id' => 'required|integer|exists:branches,id',
        // 'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048'
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

    if (!empty($data)) {
        // If the employee exists, prepare to update
        $datatoupdate = $request->only(['name', 'number', 'description', 'gender', 'position', 'branch_id']);
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '_image.' . $image->getClientOriginalExtension();
            $image->move(public_path('uploads'), $fileName);
            $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path
        }

        // Check if leader_id is provided and is not the string 'null'
        $leaderId = $request->leader_id;
        $datatoupdate['leader_id'] = ($leaderId !== 'null' && $leaderId !== null) ? $leaderId : null;

        // Perform the update
        $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance
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
    } else {
        // If the employee does not exist
        return response()->json([
            'code' => 404,
            'message' => 'Employee not found'
        ], 404);
    }
}



public function set_new_employees(Request $request){
    // Define custom error messages
    $messages = [
        'name.required' => 'Please enter a name.',
        'number.required' => 'Please enter a number.',
        'description.required' => 'Please enter a description.',
        'gender.required' => 'Please select a gender.',
        'position.required' => 'Please enter a position.',
        'branch_id.required' => 'Please select a branch.',
        'branch_id.exists' => 'The selected branch does not exist.',
        'image.image' => 'Please upload a valid image file.',
        'leader_id.exists' => 'The selected leader does not exist.',
    ];

    // Validate the request data with custom messages
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|max:255',
        'number' => 'required|string|max:255',
        'description' => 'required|string',
        'gender' => 'required|string|max:10',
        'position' => 'required|string|max:255',
        'branch_id' => 'required|integer|exists:branches,id',
        'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
        'leader_id' => 'nullable|integer|exists:employees,id', // Adding validation for leader_id
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
    $datatoinsert = $request->only(['name', 'number', 'description', 'gender', 'position', 'branch_id', 'leader_id']);
    if ($request->hasFile('image')) {
        $image = $request->file('image');
        $fileName = time() . '_image.' . $image->getClientOriginalExtension();
        $image->move(public_path('uploads'), $fileName);
        $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
    }

    $is_exsist = Employees::where($datatoinsert)->get();
    if ($is_exsist->isNotEmpty()) {
        $response = ["code" => 403, "message" => "Employee already exists"];
    } else {
        $datatoinsert['created_at'] = now();
        $flags = Employees::create($datatoinsert); // Assuming Employees model is fillable

        if ($flags) {
            $response = ["code" => 200, "message" => "Employee created successfully"];
        } else {
            $response = ["code" => 500, "message" => "Failed to create employee"];
        }
    }

    return response()->json($response);
}












// public function update_employees(Request $request) {
//     // Define custom error messages
//     $messages = [
//         'id.required' => 'The ID is required.',
//         'id.exists' => 'The employee does not exist.',
//         'name.required' => 'Please enter a name.',
//         'number.required' => 'Please enter a number.',
//         'description.required' => 'Please enter a description.',
//         'gender.required' => 'Please select a gender.',
//         'position.required' => 'Please enter a position.',
//         'branch_id.required' => 'Please select a branch.',
//         'branch_id.exists' => 'The selected branch does not exist.',
//         'image.image' => 'Please upload a valid image file.',
//         'leader_id.exists' => 'The selected leader does not exist.',
//     ];

//     // Validate the request data with custom messages
//     $validator = Validator::make($request->all(), [
//         'id' => 'required|exists:employees,id',
//         'name' => 'required|string|max:255',
//         'number' => 'required|string|max:255',
//         'description' => 'required|string',
//         'gender' => 'required|string|max:10',
//         'position' => 'required|string|max:255',
//         'branch_id' => 'required|integer|exists:branches,id',
//         'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
//         'leader_id' => 'nullable|integer|exists:employees,id', // Adding validation for leader_id
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
//         $datatoupdate = $request->only(['name', 'number', 'description', 'gender', 'position', 'branch_id', 'leader_id']);
//         if ($request->hasFile('image')) {
//             $image = $request->file('image');
//             $fileName = time() . '_image.' . $image->getClientOriginalExtension();
//             $image->move(public_path('uploads'), $fileName);
//             $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path
//         }

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


 
 public function delete_employees(Request $request)
 {
    $data = Employees::select("*")->find($request->id);  
 
    if(!empty($data)){
        Employees::where(['id'=>$request->id])->delete();
        return response()->json([  
            'code' => 200,  
            'message' => 'Element deleted companies'  
        ], 200);
 
    }
    else{  
        
        return response()->json([  
            'code' => 404,  
            'message' => 'Element not found companies'  
        ], 404);  
    
 
    }
 
 }
}
