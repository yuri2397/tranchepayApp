<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendHelpMail extends Mailable
{
    use Queueable, SerializesModels;
    public $full_name;
    public $email;
    public $message;
    public $telephone;
    public $site;
    public $entreprise;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($email, $full_name, $message, $telephone = null, $site = null, $entreprise = null)
    {
        $this->full_name = $full_name;
        $this->email = $email;
        $this->message = $message; 
        $this->telephone = $telephone;
        $this->site = $site;
        $this->entreprise = $entreprise;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject("TranchePay, formulaire de contact.")
        ->markdown("emails.send-help-mail")->with([
            "full_name" => $this->full_name,
            "email" => $this->email,
            "message" => $this->message,
            "telephone" => $this->telephone,
            "site" => $this->site,
            "entreprise" => $this->entreprise,
        ]);
    }
}
