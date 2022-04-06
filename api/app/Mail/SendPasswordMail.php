<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendPasswordMail extends Mailable
{
    use Queueable, SerializesModels;
    public $full_name;
    public $email;
    public $password;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($email, $full_name, $password)
    {
        $this->full_name = $full_name;
        $this->email = $email;
        $this->password = $password;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject("TranchePay, formulaire de contact.")
        ->markdown("emails.send-password-mail")->with([
            "full_name" => $this->full_name,
            "email" => $this->email,
            "password" => $this->password,

        ]);
    }
}
