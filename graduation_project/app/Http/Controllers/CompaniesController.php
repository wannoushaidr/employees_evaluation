<?php

namespace App\Http\Controllers;
use App\Models\Companies;

use Illuminate\Http\Request;

class CompaniesController extends Controller
{
    public function index()
    {

       $data=Companies::select('*')->orderby("id","ASC")->paginate(4);
       return view('company.index',['data'=>$data]);


        /*$branches=Branches::latest()->paginate(5);
        return view('branch.index',compact('branches'))
        ->with('i',(request()->input('page',1)-1)*5); */
    }

public function create()

{
   return view('company.create');
   //
}

public function store(Request $request)
{
//   dd($request->all());



// $datatoinsert = [];
$datatoinsert['name'] = $request->name;
$datatoinsert['number'] = $request->number;
$datatoinsert['number_of_branches'] = $request->number_of_branches;
$datatoinsert['address'] = $request->address;
$datatoinsert['email'] = $request->email;

// Create a new Branches record
Companies::create($datatoinsert);

// Redirect with success message
return redirect()->route('companies.index')->with('success', 'company stored successfully');


}

public function edit($id)
{
   $data=Companies::select("*")->find($id);
   return view('company.edit',['data'=>$data]);

}

public function update(Request $request,$id)
{


$datatoinsert['name'] = $request->name;
$datatoinsert['number'] = $request->number;
$datatoinsert['number_of_branches'] = $request->number_of_branches;
$datatoinsert['address'] = $request->address;
$datatoinsert['email'] = $request->email;


Companies::where(['id'=>$id])->update($datatoinsert);
   return redirect()->route('companies.index')
   ->with('success','Company updtes sucessfuly');


}

public function destroy($id)
{
   // dd($id);
   Companies::where(['id'=>$id])->delete();
   return redirect()->route('companies.index')
   ->with('success','Company deleted sucessfuly');
}



////////////////////////////////////  function for companies API /////////////////////////////////////////////


public function get_all_companies(){
   $data=Companies::select('*')->orderby("id","ASC")->paginate(4);
   return response()->json($data);
   // return view('branch.index',['data'=>$data]);
}

public function set_new_companies(Request $request){
   
   $datatoinsert['name'] = $request->name;
   $datatoinsert['number'] = $request->number;
   $datatoinsert['number_of_branches'] = $request->number_of_branches;
   $datatoinsert['email'] = $request->email;
   $datatoinsert['address'] = $request->address;
   $is_exsist= Companies::select("*")->where($datatoinsert)->get();
   if(!empty($is_exsist) and count($is_exsist)>0){
       $response=array("code"=>403,"message"=>"exists befor companies");
   }
   else{
       // $datatoinsert['created_at']=date("Y-m-d H:i:s");

   $flags=insert(new Companies(),$datatoinsert);
    if ($flags){
       $response=array("code"=>200,"message"=>"created succfully companies");
    }
   else{
       $response=array("code"=>401,"message"=>"created succfully companies");
   }
}

   return response()->json($response);
}

public function update_companies(Request $request) {  
   // Find the existing branch by ID  
   $data = Companies::select("*")->find($request->id);  

   if (!empty($data) ){  
       // If the branch exists, prepare to update  
       $datatoupdate = []; // Initialize an array to hold the data to update  
       $datatoupdate['name'] = $request->name;
       $datatoupdate['number'] = $request->number;
       $datatoupdate['number_of_branches'] = $request->number_of_branches;
       $datatoupdate['email'] = $request->email;
       $datatoupdate['address'] = $request->address;
         // Perform the update  
       $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance  
       if ($updated) {  
           return response()->json([  
               'code' => 200,  
               'message' => 'Data updated successfully companies'  
           ]);  
       } else {  
           return response()->json([  
               'code' => 500,  
               'message' => 'Failed to update data companies'  
           ], 500);  
       }  
   } else {  
       // If the branch does not exist  
       return response()->json([  
           'code' => 404,  
           'message' => 'Element not found companies'  
       ], 404);  
   }  

}

public function delete_companies(Request $request)
{
   $data = Companies::select("*")->find($request->id);  

   if(!empty($data)){
      Companies::where(['id'=>$request->id])->delete();
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
