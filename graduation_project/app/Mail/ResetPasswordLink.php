<?php  

namespace App\Mail;  // Correct namespace declaration  

use Illuminate\Bus\Queueable;  
use Illuminate\Contracts\Queue\ShouldQueue;  
use Illuminate\Mail\Mailable;  
use Illuminate\Queue\SerializesModels;  

class ResetPasswordLink extends Mailable  
{  
    use Queueable, SerializesModels;  

    /**  
     * Create a new message instance.  
     *  
     * @return void  
     */  
    public function __construct()  
    {  
        //  
    }  

    /**  
     * Build the message.  
     *  
     * @return $this  
     */  
    public function build()  
    {  
        // return $this->markdown('emails.reset_password_link');  
        return $this->subject('Reset Password Notification')  
                    ->view('emails.reset_password') // Assuming this view exists  
                    ->with(['token' => $this->token]);
    }  
}