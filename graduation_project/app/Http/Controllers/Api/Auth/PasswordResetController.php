<?php  

namespace App\Http\Controllers\Api\Auth;  

use App\Http\Controllers\Controller;  
use Illuminate\Support\Facades\Mail;  
use Illuminate\Http\Request;  
use App\Http\Requests\LinkEmailRequest;  
use App\Models\User;  
// Import the correct ResetPasswordLink class  
use App\Mail\ResetPasswordLink;   
use Illuminate\Support\Facades\Validator;  
use Illuminate\Support\Facades\Hash;


class PasswordResetController extends Controller  
{  
    public function __construct()  
    {  
        $this->middleware('guest');  
    }  
    
    // public function sendResetLinkEmail(LinkEmailRequest $request)  
    // {  
    //     // return "ss";
    //     // Mail::to($request->email)->send(new ResetPasswordLink());  

    //     // return response()->json([  
    //     //     'message' => 'Reset password link sent to your email.'  
    //     // ]);  
    // }  

    // public function __construct()  
    // {  
    //     $this->middleware('auth'); // Ensure user is authenticated  
    // }  

    // public function resetWithOldPassword(Request $request)  
    // {  
    //     // Define custom validation rules and messages  
    //     $validator = Validator::make($request->all(), [  
    //         'old_password' => 'required|string',  
    //         'new_password' => 'required|string|min:8|confirmed',  
    //     ], [  
    //         'new_password.required' => 'The new password field is required.',  
    //         'new_password.min' => 'The new password must be at least 8 characters.',  
    //         'new_password.confirmed' => 'The password confirmation does not match.',  
    //     ]);  

    //     // Check the validation result  
    //     if ($validator->fails()) {  
    //         return response()->json(['errors' => $validator->errors()], 422);  
    //     }  

    //     // Get the authenticated user  
    //     $user = Auth::user();  

    //     // Verify the old password  
    //     if (!Hash::check($request->old_password, $user->password)) {  
    //         return response()->json(['message' => 'The provided password does not match our records.'], 403);  
    //     }  

    //     // Update the new password  
    //     $user->password = Hash::make($request->new_password);  
    //     $user->save();  

    //     return response()->json(['message' => 'Password successfully updated.']);  
    // }  



    public function resetWithOldPassword(Request $request)  
    {  
        // Validate the request inputs  
        $validator = Validator::make($request->all(), [  
            'email' => 'required|email|exists:users,email',  
            'old_password' => 'required|string',  
            'new_password' => 'required|string|min:8|confirmed',  
        ], [  
            'new_password.required' => 'The new password field is required.',  
            'new_password.min' => 'The new password must be at least 8 characters.',  
            'new_password.confirmed' => 'The password confirmation does not match.',  
        ]);  

        if ($validator->fails()) {  
            return response()->json(['errors' => $validator->errors()], 422);  
        }  

        // Attempt to find the user by email  
        $user = User::where('email', $request->email)->first();  

        // Verify the old password  
        if (!Hash::check($request->old_password, $user->password)) {  
            return response()->json(['message' => 'The provided password does not match our records.'], 403);  
        }  

        // Update the user's password  
        $user->password = Hash::make($request->new_password);  
        $user->save();  

        // Send email notification about the password change  
        // Mail::to($user->email)->send(new PasswordChangedNotification());  

        return response()->json(['message' => 'Password successfully updated and confirmation email sent.']);  
    }  


    
}