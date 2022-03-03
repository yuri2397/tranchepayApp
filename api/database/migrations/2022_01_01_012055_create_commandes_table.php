<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCommandesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('commandes', function (Blueprint $table) {
            $table->uuid('id')->primary();

            $table->string("prix_total");
            $table->unsignedInteger("nb_produits")->default(0);
            $table->unsignedInteger("interet")->default(0);
            $table->unsignedInteger("nb_tranche")->default(3);
            $table->dateTime("date_time")->default(now());
            $table->date("date_limite");
            $table->double("commission")->default(0);


            $table->uuid("boutique_id");
            $table->uuid("client_id");
            $table->uuid("etat_commande_id");
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
        Schema::dropIfExists('commandes');
    }
}
