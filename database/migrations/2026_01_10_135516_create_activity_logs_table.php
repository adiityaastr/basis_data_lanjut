<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (!Schema::hasTable('activity_logs')) {
            Schema::create('activity_logs', function (Blueprint $table) {
            $table->id('log_id');
            $table->string('table_name', 50);
            $table->string('action', 20); // INSERT, UPDATE, DELETE
            $table->text('old_data')->nullable();
            $table->text('new_data')->nullable();
            $table->string('record_id', 50)->nullable();
            $table->timestamp('created_at')->useCurrent();
            
            // Index sesuai SQL
            $table->index('table_name', 'idx_table_name');
            $table->index('action', 'idx_action');
            $table->index('record_id', 'idx_record_id');
            $table->index('created_at', 'idx_created_at');
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('activity_logs');
    }
};
