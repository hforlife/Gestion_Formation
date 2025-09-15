<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ContactMail extends Mailable
{
    use Queueable, SerializesModels;

    public $data;

    /**
     * Crée une nouvelle instance du Mailable.
     */
    public function __construct($data)
    {
        $this->data = $data;
    }

    /**
     * Construire le message.
     */
    public function build()
    {
        return $this->subject($this->data['subject'])
                    ->view('emails.contact')
                    ->with('data', $this->data);
    }
}
