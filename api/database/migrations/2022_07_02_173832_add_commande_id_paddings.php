<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCommandeIdPaddings extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('paddings', function (Blueprint $table) {
            $table->uuid("commande_id")->nullable();
            $table->foreign("commande_id")->references("id")->on("commandes");
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
