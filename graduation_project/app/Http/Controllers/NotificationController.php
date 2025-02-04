<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Notifications\NotificatiForCustmoerService;
use App\Models\User;
use App\Models\Employees;


class NotificationController extends Controller
{
    public function send(Request $request)
    {
        $user = User::find($request->input('id'));
        if ($user) {
            $data = [
                'id' => $request->id,
                'title' => $request->title,
                'body' => $request->body,
                'url' => url('/')
            ];
            $user->notify(new NotificatiForCustmoerService($data));
            return response()->json(['message' => 'Notification sent successfully']);
        }
        return response()->json(['message' => 'User not found'], 404);
    }
}
