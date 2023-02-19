<?php 
namespace App\Providers\Services;

use Kutia\Larafirebase\Services\Larafirebase;


class FireBaseService
{

    private Larafirebase $_fireBaseService;

    public function __construct(Larafirebase $fireBaseService)
    {
        $this->_fireBaseService = $fireBaseService;
    }

    public function sendMessage($title, $body, array $tokens)
    {
        return $this->_fireBaseService->withTitle($title)
            ->withBody($body)
            ->withIcon('https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png')
            ->withSound('default')
            ->sendMessage($tokens);
    }
}
