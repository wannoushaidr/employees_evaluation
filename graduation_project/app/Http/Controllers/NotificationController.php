<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Notifications\NotificatiForCustmoerService;
use App\Models\User;

class NotificationController extends Controller
{
    public function send(Request $request)
    {
        $user = User::find($request->input('user_id'));
        if ($user) {
            $data = [
                'title' => 'Notification Title',
                'body' => 'Notification Body',
                'url' => url('/')
            ];
            $user->notify(new NotificatiForCustmoerService($data));
            return response()->json(['message' => 'Notification sent successfully']);
        }
        return response()->json(['message' => 'User not found'], 404);
    }
}
