<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class NotificationController2 extends Controller
{
    static public function notify($title,$body,$device_key){
        $url="";
        $serverkey="";

        $dataArr=[
            "click_action"=>"FLUTTER_NOTIFICATION_CLICK",
            "status"=>"danoe",
        ];

        $data = [
            "registration_ids"=>[$device_key],
            "notification"=>[
                "title"=>$title,
                "body"=>$body,
                "sound"=>"default",
                
            ],
            "data"=>$dataArr,
            "priority"=>"high"
        ];

        $encodeData = json_encode($data);

        $headers = [
            "Authorization:key=",$serverkey,
            "Content-Type: application/json",
        ];

        $ch=curl_init();

        curl_setopt($ch,CURLOPT_URL,$url);
        curl_setopt($ch,CURLOPT_POST,$url);
        curl_setopt($ch,CURLOPT_HTTPHEADER,$headers);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
        curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,0);
        curl_setopt($ch,CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
        curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
        curl_setopt($ch,CURLOPT_POSTFIELDS,$encodeData);

        $result = curl_exec($ch);

        if($result === FALSE){
            return [
                'message'=>'failed',
                'e'=>$result,
                'success'=>false,
            ];
        }

        // close connection
        curl_close($ch);

        // FCM respnose
        // dd($result);
        return [
            'message'=>'failed',
            'e'=>$result,
            'success'=>true,
        ];




        
        
    }
}
