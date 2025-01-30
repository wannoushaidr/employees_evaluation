<?php

namespace App\Listeners;

use App\Models\User;
use App\Notifications\NotificatiForCustmoerService;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendCustomerServiceNotification
{
    /**
     * Handle the event.
     *
     * @param  object  $event
     * @return void
     */
    public function handle($event)
    {
        $user = User::find($event->user_id);
        if ($user) {
            $user->notify(new NotificatiForCustmoerService());
        }
    }
}
