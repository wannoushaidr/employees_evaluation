<?php

namespace App\Http\Controllers;

namespace App\Services;


use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;


class FirebaseServices 
{
    protected $messaging;

    public function _construct(){
        $serviceAccountPath = storage_path;
        ('clothes-store-main-firebase-adminsdk-fbsvc-2f7f958335.json');
        $factory = (new Factory)->withServiceAccount($serviceAccountPath);
        $this->messaging =$factory->createMessaging();
    }

    public function sendNotification($token , $title,$body,$data = []){
      
        $message = CloudMessage::withTarget('token',$token)
        ->withNotification(['title'=>$title,'body'=>$body])
        ->withData($data);

        $this->messaging->send($message);

        
    }
}
