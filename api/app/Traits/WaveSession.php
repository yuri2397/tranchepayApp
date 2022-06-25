<?php

namespace App\Traits;

class WaveSession
{
    private  $id;
    private  $amount;
    private  $checkout_status;
    private  $client_reference;
    private  $currency;
    private  $error_url;
    private  $last_payment_error;
    private  $business_name;
    private  $payment_status;
    private  $success_url;
    private  $wave_launch_url;
    private  $when_completed;
    private  $when_created;
    private  $when_expires;

    public function getId(){
		return $this->id;
	}

	public function setId($id){
		$this->id = $id;
	}

	public function getAmount(){
		return $this->amount;
	}

	public function setAmount($amount){
		$this->amount = $amount;
	}

	public function getCheckout_status(){
		return $this->checkout_status;
	}

	public function setCheckout_status($checkout_status){
		$this->checkout_status = $checkout_status;
	}

	public function getClient_reference(){
		return $this->client_reference;
	}

	public function setClient_reference($client_reference){
		$this->client_reference = $client_reference;
	}

	public function getCurrency(){
		return $this->currency;
	}

	public function setCurrency($currency){
		$this->currency = $currency;
	}

	public function getError_url(){
		return $this->error_url;
	}

	public function setError_url($error_url){
		$this->error_url = $error_url;
	}

	public function getLast_payment_error(){
		return $this->last_payment_error;
	}

	public function setLast_payment_error($last_payment_error){
		$this->last_payment_error = $last_payment_error;
	}

	public function getBusiness_name(){
		return $this->business_name;
	}

	public function setBusiness_name($business_name){
		$this->business_name = $business_name;
	}

	public function getPayment_status(){
		return $this->payment_status;
	}

	public function setPayment_status($payment_status){
		$this->payment_status = $payment_status;
	}

	public function getSuccess_url(){
		return $this->success_url;
	}

	public function setSuccess_url($success_url){
		$this->success_url = $success_url;
	}

	public function getWave_launch_url(){
		return $this->wave_launch_url;
	}

	public function setWave_launch_url($wave_launch_url){
		$this->wave_launch_url = $wave_launch_url;
	}

	public function getWhen_completed(){
		return $this->when_completed;
	}

	public function setWhen_completed($when_completed){
		$this->when_completed = $when_completed;
	}

	public function getWhen_created(){
		return $this->when_created;
	}

	public function setWhen_created($when_created){
		$this->when_created = $when_created;
	}

	public function getWhen_expires(){
		return $this->when_expires;
	}

	public function setWhen_expires($when_expires){
		$this->when_expires = $when_expires;
	}
}
