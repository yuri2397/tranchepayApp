<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendClientHelpMail extends Mailable
{
    use Queueable, SerializesModels;
    public $full_name;
    public $email;
    public $message;
    public $telephone;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($email, $full_name, $message, $telephone = null)
    {
        $this->full_name = $full_name;
        $this->email = $email;
        $this->message = $message;
        $this->telephone = $telephone;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject("TranchePay, formulaire de contact du client.")
        ->markdown("emails.send-client-help-mail")->with([
            "full_name" => $this->full_name,
            "email" => $this->email,
            "message" => $this->message,
            "telephone" => $this->telephone,
        ]);
    }
}
