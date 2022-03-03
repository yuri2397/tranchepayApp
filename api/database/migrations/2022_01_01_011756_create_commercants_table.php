<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCommercantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('commercants', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string("prenoms");
            $table->string("nom");
            $table->string("telephone");
            $table->string("adresse")->nullable();
            $table->string("image_path")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('commercants');
    }
}
