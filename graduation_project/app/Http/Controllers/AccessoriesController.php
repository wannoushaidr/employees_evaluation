<?php

namespace App\Http\Controllers;
use App\Models\Branches;
use App\Models\Accessories;
use Illuminate\Http\Request;

class AccessoriesController extends Controller
{
    public function index()
    {
        $data=Accessories::select('*')->orderby("id","ASC")->paginate(4);
            return view('accessory.index',['data'=>$data]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $data=Branches::select('*')->orderby("id","ASC")->paginate(100);

        return view('accessory.create',['data'=>$data]);

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
$datatoinsert['type'] = $request->type;
$datatoinsert['branch_id'] = $request->branch_id;

// Handle the uploaded files
if ($request->hasFile('image')) {
    $image = $request->file('image');
    $fileName = time() . '_image.' . $image->getClientOriginalExtension();
    $image->move(public_path('uploads'), $fileName);
    $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
}


// Create a new Branches record
Accessories::create($datatoinsert);

// Redirect with success message
return redirect()->route('accessories.index')->with('success', 'accessory stored successfully');


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
        $data=Accessories::select("*")->find($id);
        $data2=Branches::select('*')->orderby("id","ASC")->paginate(100);

        return view('accessory.edit',['data'=>$data,'data2'=>$data2]);

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
        $datatoinsert['type'] = $request->type;
        $datatoinsert['branch_id'] = $request->branch_id;

        // Handle the uploaded files
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '_image.' . $image->getClientOriginalExtension();
            $image->move(public_path('uploads'), $fileName);
            $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
    }


// Create a new Branches record
Accessories::where(['id'=>$id])->update($datatoinsert);

// Redirect with success message
return redirect()->route('accessories.index')->with('success', 'accessory updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Accessories::where(['id'=>$id])->delete();
        return redirect()->route('accessories.index')
        ->with('success','accessory deleted sucessfuly');
    }





    //    ///////////////////////////////////  function for API /////////////////////////////////////////////
    public function get_all_accesories(){
        $data=Accessories::select('*')->orderby("id","ASC")->paginate(4);
        return response()->json($data);
        // return view('branch.index',['data'=>$data]);
    }

    public function set_new_accesories(Request $request){
        
        $datatoinsert['type'] = $request->type;
        // $datatoinsert['image'] = $request->image;
        $datatoinsert['branch_id'] = $request->branch_id;
        $is_exsist= Accessories::select("*")->where($datatoinsert)->get();
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '_image.' . $image->getClientOriginalExtension();
            $image->move(public_path('uploads'), $fileName);
            $datatoinsert['image'] = 'uploads/' . $fileName; // Save relative path
        }
        if(!empty($is_exsist) and count($is_exsist)>0){
            $response=array("code"=>403,"message"=>"exists befor Branches");
        }
        else{
            $datatoinsert['created_at']=date("Y-m-d H:i:s");

        $flags=insert(new Accessories(),$datatoinsert);
         if ($flags){
            $response=array("code"=>200,"message"=>"created succfully Branches");
         }
        else{
            $response=array("code"=>401,"message"=>"created succfully Branches");
        }
    }

        return response()->json($response);
     }

     
     public function update_accesories(Request $request) {  
        // Find the existing branch by ID  
        $data = Accessories::select("*")->find($request->id);  
    
        if (!empty($data) ){  
            // If the branch exists, prepare to update  
            $datatoupdate = []; // Initialize an array to hold the data to update  
            // $datatoupdate['image'] = $request->image;  
            $datatoupdate['branch_id'] = $request->branch_id;  
            $datatoupdate['type'] = $request->type;  
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $fileName = time() . '_image.' . $image->getClientOriginalExtension();
                $image->move(public_path('uploads'), $fileName);
                $datatoupdate['image'] = 'uploads/' . $fileName; // Save relative path
            }
           
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

    public function delete_accesories(Request $request)
    {
        $data = Accessories::select("*")->find($request->id);  

        if(!empty($data)){
            Accessories::where(['id'=>$request->id])->delete();
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
