<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAccessoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('accessories', function (Blueprint $table) {
            $table->id()->unique();
            $table->enum('type',['exit_door','dressing_room'])->notNull();
            $table->string('image')->notNull();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade'); // Foreign key with constraints
            $table->timestamps();
            $table->softDeletes();


            // $table->string('name',100)->notNull();
            // $table->text('description')->notNull();
            // $table->integer('number')->notNull()->unique();
            // $table->enum('gender',['male','female'])->notNull();
            // $table->enum('position',['manager', 'supervisor', 'customer_service'])->notNull();
            // $table->foreignId('leader_id')->nullable()->onDelete('no action'); // Matches data type
            // $table->string('image',300)->notNull();
            // $table->foreignId('branch_id')->notNull()->constrained('branches')->onDelete('no action'); // Self-referential foreign key





        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('accessories');
    }
}
