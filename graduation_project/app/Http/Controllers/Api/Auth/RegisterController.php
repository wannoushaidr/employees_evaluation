<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\RegisterRequest;
use App\Models\User;


class RegisterController extends Controller
{

    public function __construct()
    {
        $this->middleware('guest');

    }

    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $req   uest
     * @return \Illuminate\Http\Response
     */
    public function __invoke(RegisterRequest $request)
    {
        $user = User::create([
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'role' => $request->role, // Make sure to include the role  


        ]);
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json(['access_token'=>$token,'token_type'=>'Bearer'],200);



    }


}
