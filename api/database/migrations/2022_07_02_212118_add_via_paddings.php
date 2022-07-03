<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddViaPaddings extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('paddings', function (Blueprint $table) {
            $table->string("via")->nullable();
            $table->string("amount");
            $table->json("extra")->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('paddings', function (Blueprint $table) {
            //
        });
    }
}
