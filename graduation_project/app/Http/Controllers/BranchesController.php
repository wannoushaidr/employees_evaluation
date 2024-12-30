<?php

namespace App\Http\Controllers;

use App\Models\Branches;
use App\Models\Companies;
use Illuminate\Http\Request;
use App\Rules\ValidateMines;

// to make validate for field "app/Request/CreateBranchRequest"
use App\Http\Requests\CreateBranchRequest;
use Illuminate\Support\Facades\Validator;
// to make pagination for multiple pages path"app/privders/AppServiceProvider"
use Illuminate\Pagination\Paginator;


class BranchesController extends Controller
{



     public function index()
         {

            // // // to run function in helpers  lesson 27
            // // // Helpers function in this path "app/helpers/helpers.php"
            // // // and we add  this " files":["app/Helpers/General.php"] " in this path composer.json
            // // // then we run this command " composer dump-autoload" in command line to refresh helpers function
            // helper_function();

            //$company=Companies::select('*')->orderby("id","ASC")->paginate();
            $data=Branches::select('*')->orderby("id","ASC")->paginate(10);
            return view('branch.index',['data'=>$data]);

            // ***************************************************************
            // by using helper 
            // $data=get_cols_where_p(new Branches(),array('*'),array("id"=>1),'id','ASC',6 );
            // i can put no thing in query like this "
            // $data=get_cols_where_p(new Branches(),array('*'),array(),'id','ASC',6 );
            //  $data=get_cols_where_p(new Branches(),array('*'),array(["email", '!=', '']),'id','ASC',6 );


            //  return view('branch.index',['data'=>$data]);





         }


        


    public function create()

    {
        $data=Companies::select('*')->orderby("id","ASC")->paginate(100);
        return view('branch.create',['data'=>$data]);
        //
    }

    public function store(CreateBranchRequest $request)
    {
    //   dd($request->all());



        // $datatoinsert = [];
        $datatoinsert['name'] = $request->name;
        $datatoinsert['phone'] = $request->phone;

        // // Handle the uploaded files
        // if ($request->hasFile('exit_image')) {
        //     $image = $request->file('exit_image');
        //     $fileName = time() . '_exit.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['exit_image'] = 'uploads/' . $fileName; // Save relative path
        // }

        // if ($request->hasFile('table_image')) {
        //     $image = $request->file('table_image');
        //     $fileName = time() . '_table.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['table_image'] = 'uploads/' . $fileName; // Save relative path
        // }

        // if ($request->hasFile('fit_clothes_image')) {
        //     $image = $request->file('fit_clothes_image');
        //     $fileName = time() . '_fit.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['fit_clothes_image'] = 'uploads/' . $fileName; // Save relative path
        // }

                $datatoinsert['address'] = $request->address;
                $datatoinsert['email'] = $request->email;
                $datatoinsert['company_id'] = $request->company_id;


                // // Create a new Branches record
                Branches::create($datatoinsert);

                // // insert by using Helper
                // insert(new Branches(), $datatoinsert);

                // Redirect with success message
                return redirect()->route('branches.index')->with('success', 'Branches stored successfully');


    }


    



    public function edit($id)
     {

         $data=Branches::select("*")->find($id);
        // // to select by helpers just specific column to show
        // // like this :
        // // $data=get_cols_where_row(new Branches(),array("*"),array("id"=>$id));
        // // or like this:
        // // $data=get_cols_where_row(new Branches(),array("id",'name'),array("id"=>$id));

        
        $data2=Companies::select('*')->orderby("id","ASC")->paginate(100);

        return view('branch.edit',['data'=>$data,'data2'=>$data2]);

    }

    public function update(CreateBranchRequest $request,$id)
     {


        $datatoinsert['name'] = $request->name;
        $datatoinsert['phone'] = $request->phone;

        // // Handle the uploaded files
        // if ($request->hasFile('exit_image')) {
        //     $image = $request->file('exit_image');
        //     $fileName = time() . '_exit.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['exit_image'] = 'uploads/' . $fileName; // Save relative path
        // }

        // if ($request->hasFile('table_image')) {
        //     $image = $request->file('table_image');
        //     $fileName = time() . '_table.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['table_image'] = 'uploads/' . $fileName; // Save relative path
        // }

        // if ($request->hasFile('fit_clothes_image')) {
        //     $image = $request->file('fit_clothes_image');
        //     $fileName = time() . '_fit.' . $image->getClientOriginalExtension();
        //     $image->move(public_path('uploads'), $fileName);
        //     $datatoinsert['fit_clothes_image'] = 'uploads/' . $fileName; // Save relative path
        // }

        $datatoinsert['address'] = $request->address;
        $datatoinsert['email'] = $request->email;
        $datatoinsert['company_id'] = $request->company_id;


        Branches::where(['id'=>$id])->update($datatoinsert);
        // // by using helper
        // update(new Branches(),$datatoinsert,array("id"=>$id));

        return redirect()->route('branches.index')
        ->with('success','branches updtes sucessfuly');


    }

    public function destroy($id)
    {
        // // dd($id);
        Branches::where(['id'=>$id])->delete();
        // // by using helper
        //  delete(new Branches(),array("id"=>$id));


        return redirect()->route('branches.index')
        ->with('success','branches deleted sucessfuly');
   }


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//    ///////////////////////////////////  function for API /////////////////////////////////////////////
    public function get_all_branches(){
        $data=Branches::select('*')->orderby("id","ASC")->paginate(10);
        return response()->json($data);
        // return view('branch.index',['data'=>$data]);
    }

    public function set_new_branches(Request $request){
        
        $datatoinsert['name'] = $request->name;
        $datatoinsert['phone'] = $request->phone;
        $datatoinsert['address'] = $request->address;
        $datatoinsert['email'] = $request->email;
        $datatoinsert['company_id'] = $request->company_id;
        $is_exsist= Branches::select("*")->where($datatoinsert)->get();
        if(!empty($is_exsist) and count($is_exsist)>0){
            $response=array("code"=>403,"message"=>"exists befor Branches");
        }
        else{
            $datatoinsert['created_at']=date("Y-m-d H:i:s");

        $flags=insert(new Branches(),$datatoinsert);
         if ($flags){
            $response=array("code"=>200,"message"=>"created succfully Branches");
         }
        else{
            $response=array("code"=>401,"message"=>"created succfully Branches");
        }
    }

        return response()->json($response);
     }

     public function update_branches(Request $request) {  
        // Find the existing branch by ID  
        $data = Branches::select("*")->find($request->id);  
    
        if (!empty($data) ){  
            // If the branch exists, prepare to update  
            $datatoupdate = []; // Initialize an array to hold the data to update  
            $datatoupdate['name'] = $request->name;  
            $datatoupdate['phone'] = $request->phone;  
            $datatoupdate['address'] = $request->address;  
            $datatoupdate['email'] = $request->email;  
            $datatoupdate['company_id'] = $request->company_id;  
    
            // Perform the update  
            $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance  
            if ($updated) {  
                return response()->json([  
                    'code' => 200,  
                    'message' => 'Data updated successfully Branches'  
                ]);  
            } else {  
                return response()->json([  
                    'code' => 500,  
                    'message' => 'Failed to update data Branches'  
                ], 500);  
            }  
        } else {  
            // If the branch does not exist  
            return response()->json([  
                'code' => 404,  
                'message' => 'Element not found Branches'  
            ], 404);  
        }  
    
    }

    public function delete_branches(Request $request)
    {
        $data = Branches::select("*")->find($request->id);  

        if(!empty($data)){
            Branches::where(['id'=>$request->id])->delete();
            return response()->json([  
                'code' => 200,  
                'message' => 'Element deleted Branches'  
            ], 200);

        }
        else{  
            
            return response()->json([  
                'code' => 404,  
                'message' => 'Element not found Branches'  
            ], 404);  
        

        }

    }



    

}
