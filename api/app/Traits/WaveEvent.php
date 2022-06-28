<?php

namespace App\Traits;

class WaveEvent{

    private $id;
    private $type;
    private $data;


    public function getId()
    {
        return $this->id;
    }

    public function getType()
    {
        return $this->type;
    }

    public function getData()
    {
        return $this->data;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
    public function setType($type)
    {
        $this->type = $type;
    }

    public function setData($data)
    {
        $this->data = $data;
    }

}