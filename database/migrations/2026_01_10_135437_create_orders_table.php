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
        if (!Schema::hasTable('orders')) {
            Schema::create('orders', function (Blueprint $table) {
            $table->id('order_id');
            $table->unsignedBigInteger('customer_id');
            $table->dateTime('order_date');
            $table->decimal('order_total', 10, 2);
            $table->string('status', 20)->default('pending');
            $table->timestamps();
            
            $table->foreign('customer_id')
                  ->references('customer_id')
                  ->on('customers')
                  ->onDelete('cascade');
            
            // Index sesuai SQL
            $table->index('customer_id', 'idx_customer_id');
            $table->index('order_date', 'idx_order_date');
            $table->index('status', 'idx_status');
            $table->index('order_total', 'idx_order_total');
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
