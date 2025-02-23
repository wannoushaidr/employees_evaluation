<?php

namespace App\Http\Controllers;

use App\Services\FirebaseService;
use Illuminate\Http\Request;


class NotificationFireBaseController extends Controller
{
    protected $firebaseService;

    public function _construct(FirebaseService $firebaseService ){
        $this->firebaseService = $firebaseService;
    }

    public function sendPushNotification(Request $request){
        $request->validate([
            'token'=>'required|string',
            'title'=>'required|string',
            'body'=>'required|string',
            'data'=>'required|array',

        ]);

        $token = $request->input('token');
        $title = $request->input('title');
        $body = $request->input('body');
        $data = $request->input('data');

        $this->firebaseService->sendNotification($token,$title,$body,$data);

        return reponse()->json(['message'=>'Notification sent successfully']);
        
    }
}
