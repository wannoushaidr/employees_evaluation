<?php  

namespace App\Http\Controllers\Api\Auth;  

use App\Http\Controllers\Controller;  
use App\Models\User;  
use Illuminate\Support\Facades\Hash;  
use Illuminate\Support\Facades\Mail;  
use Illuminate\Support\Str;  
use Illuminate\Support\Facades\DB;  
use Illuminate\Support\Facades\Validator;  
use Exception;  

class PasswordResetController extends Controller  
{  
    public function __construct()  
    {  
        $this->middleware('guest');  
    }  

    public function sendResetLinkEmail(Request $request)  
    {  
        return response()->json([  
            'message' => 'Reset password link sent to your email.'  
        ]); 
        
        try {  
            $user = User::where('email', $request->email)->first();  

            if ($user) {  
                // Generate a random token  
                $token = Str::random(60);  
                
                // Store token in the password_resets table  
                DB::table('password_resets')->insert([  
                    'email' => $request->email,  
                    'token' => $token,  
                    'created_at' => now(),  
                ]);  

                // Send the email  
                Mail::to($request->email)->send(new ResetPasswordLink($token));  

                return response()->json([  
                    'message' => 'Reset password link sent to your email.'  
                ]);  
            }  

            return response()->json(['message' => 'User not found.'], 404);  
        } catch (Exception $e) {  
            return response()->json(['message' => 'Error sending reset link: ' . $e->getMessage()], 500);  
        }  
    }  

    public function reset(Request $request)  
    {  
        // Define custom validation rules and messages  
        $validator = Validator::make($request->all(), [  
            'token' => 'required',  
            'password' => 'required|string|min:8|confirmed',  
        ], [  
            'password.required' => 'The password field is required.',  
            'password.min' => 'The password must be at least 8 characters.',  
            'password.confirmed' => 'The password confirmation does not match.',  
        ]);  

        // Check the validation result  
        if ($validator->fails()) {  
            return response()->json(['errors' => $validator->errors()], 422);  
        }  

        try {  
            // Check if the token exists  
            $reset = DB::table('password_resets')->where('token', $request->token)->first();  

            if (!$reset) {  
                return response()->json(['message' => 'Invalid token.'], 400);  
            }  

            // Find the user by email  
            $user = User::where('email', $reset->email)->first();  

            if (!$user) {  
                return response()->json(['message' => 'User not found.'], 404);  
            }  

            // Hash and save the new password  
            $user->password = Hash::make($request->password);  
            $user->save();  

            // Delete the token after use  
            DB::table('password_resets')->where('email', $reset->email)->delete();  

            return response()->json(['message' => 'Password successfully reset.']);  
        } catch (Exception $e) {  
            return response()->json(['message' => 'Error resetting password: ' . $e->getMessage()], 500);  
        }  
    }  
}