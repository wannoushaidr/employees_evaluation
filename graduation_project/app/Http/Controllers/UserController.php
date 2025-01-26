<?php

namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

use Illuminate\Support\Facades\Validator;

use Illuminate\Http\Request;

class UserController extends Controller
{
        
        public function get_all_users(){
            $data=User::select('*')->orderby("id","ASC")->get();
                return response()->json($data);
        }
        
         
        public function set_new_admins(Request $request)
        {  

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
                'password.required' => 'Please enter a password.',  
                // 'password.min' => 'The password must be at least 8 characters.',  
            ];
            // Validate the request  
            $validator = Validator::make($request->all(), [  
                'name' => 'required|string|max:255',  
                'role' => 'required|string|max:255',  
                'email' => 'required|email|max:255|unique:users,email', // Ensure email uniqueness  
                'password' => [  
                    'required',  
                    'string',  
                    'min:8', // Minimum of 8 characters  
                    'regex:/[a-zA-Z]/', // At least one letter  
                    'regex:/[0-9]/', // At least one number  
                ],  
            ], $messages);  
        
            if ($validator->fails()) {  
                return response()->json($validator->errors(), 422); // Handle validation errors  
            }  
            
            // Hash the password  
            $dataToInsert = $request->only(['name', 'email', 'role']);  
            $dataToInsert['password'] = Hash::make($request->input('password')); // Hash the password  
        
            // Check if user already exists (by email)  
            $isExist = User::where('email', $dataToInsert['email'])->exists();  
        
            if ($isExist) {  
                return response()->json(['error' => 'User with this email already exists.'], 409); // Conflict response  
            }  
        
            // Save the user  
            $user = User::create($dataToInsert); // Assuming the User model allows mass assignment for these fields  
        
            return response()->json(['message' => 'User created successfully.', 'user' => $user], 200); // Success response  
        }  
        
               

    public function update_admins(Request $request)   
    {  
        // Define custom error messages  
        $messages = [  
            'id.required' => 'The ID is required.',  
            'id.exists' => 'The company does not exist.',  
            'name.required' => 'Please enter a name.',  
            'email.required' => 'Please enter an email address.',  
            'email.email' => 'Please enter a valid email address.',  
            'password.regex' => 'Password must contain at least one letter and one number.',  
            'password.min' => 'Password must be at least 8 characters long.',   
            'role.required' => 'Please enter a role.',  
        ];  
    
        // Validate the request data with custom messages  
        $validator = Validator::make($request->all(), [  
            'id' => 'required|exists:users,id', // Ensure to validate if the ID exists  
            'name' => 'required|string|max:255',  
            'email' => 'required|email|max:255',  
            'role' => 'required|string|max:255',  
            // Make password optional by using 'nullable' and keep other rules if provided  
            'password' => [  
                'nullable',  // This allows the password to be omitted  
                'string',  
                'min:8', // Minimum of 8 characters  
                'regex:/[a-zA-Z]/', // At least one letter  
                'regex:/[0-9]/', // At least one number  
            ],   
        ], $messages);  
    
        if ($validator->fails()) {  
            // Return the validation error messages  
            return response()->json([  
                'code' => 422,  
                'message' => 'Validation error',  
                'errors' => $validator->errors()  
            ], 422);  
        }  
    
        // Find the existing user by ID  
        $data = User::select("*")->find($request->id);  
    
        if (!empty($data)) {  
            // If the user exists, prepare to update  
            $datatoupdate = $request->only(['name', 'email', 'role']);   
    
            // Check if the password is provided and hash it  
            if ($request->filled('password')) {  
                $datatoupdate['password'] = Hash::make($request->input('password')); // Hash the password  
            }  
    
            // Perform the update  
            $updated = $data->update($datatoupdate); // Using Eloquent's update method directly on the model instance  
            if ($updated) {  
                return response()->json([  
                    'code' => 200,  
                    'message' => 'admin Data updated successfully'  
                ]);  
            } else {  
                return response()->json([  
                    'code' => 500,  
                    'message' => 'Failed to update admin data'  
                ], 500);  
            }  
        } else {  
            // If the user does not exist  
            return response()->json([  
                'code' => 404,  
                'message' => 'admin not found'  
            ], 404);  
        }  
    }
        


    
        public function delete_admins(Request $request)
        {
            $data = User::select("*")->find($request->id);  
        
            if(!empty($data)){
                User::where(['id'=>$request->id])->delete();
                return response()->json([  
                    'code' => 200,  
                    'message' => 'user deleted '  
                ], 200);
        
            }
            else{  
                
                return response()->json([  
                    'code' => 404,  
                    'message' => 'admin not founded '  
                ], 404);  
                    
            }
        
        }
            
}
