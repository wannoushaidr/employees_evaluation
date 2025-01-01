<?php  

namespace App\Http\Controllers\Api\Auth;  

use App\Http\Controllers\Controller;  
use Illuminate\Support\Facades\Mail;  
use Illuminate\Http\Request;  
use App\Http\Requests\LinkEmailRequest;  
use App\Models\User;  
// Import the correct ResetPasswordLink class  
use App\Mail\ResetPasswordLink;   

class PasswordResetController extends Controller  
{  
    public function __construct()  
    {  
        $this->middleware('guest');  
    }  
    
    public function sendResetLinkEmail(LinkEmailRequest $request)  
    {  
        // Mail::to($request->email)->send(new ResetPasswordLink());  

        // return response()->json([  
        //     'message' => 'Reset password link sent to your email.'  
        // ]);  
    }  
}