<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBoutiqueHasUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('boutique_has_users', function (Blueprint $table) {
            $table->uuid('id');
            $table->uuid('user_id');
            $table->foreign('user_id')->references("id")->on('users')->onDelete("cascade");
            $table->uuid('commande_id');
            $table->foreign('commande_id')->references("id")->on('commandes')->onDelete("cascade");
            $table->uuid('boutique_id');
            $table->foreign('boutique_id')->references("id")->on('boutiques')->onDelete("cascade");
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
        Schema::dropIfExists('boutique_has_users');
    }
}
