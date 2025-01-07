<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBranchesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('branches', function (Blueprint $table) {
            $table->id()->unique();
            $table->string('name')->notNull(false); // String column that is not nullable
            $table->integer('phone')->notNull()->unique();
            // $table->string('exit_image',300)->notNull();
            // $table->string('table_image',300)->notNull();
            // $table->string('fit_clothes_image',300)->notNull();
            $table->string('address')->notNull();
            $table->string('email')->unique()->notNull();
            $table->foreignId('company_id')->constrained()->onDelete('cascade'); // Foreign key with constraints
            #$table->foreign('company_id')->references('id')->on('companies')->onDelete('set null')->onUpdate('cascade');
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
        Schema::dropIfExists('branches');
    }
}
