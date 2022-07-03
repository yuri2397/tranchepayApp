<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveCommandeIdBoutiqueHasUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('boutique_has_users', function (Blueprint $table) {
            // $table->dropConstrainedForeignId("commande_id");
            // $table->dropColumn("commande_id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('boutique_has_users', function (Blueprint $table) {
            //
        });
    }
}
