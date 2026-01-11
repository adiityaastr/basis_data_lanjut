<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Order extends Model
{
    protected $table = 'orders';
    protected $primaryKey = 'order_id';
    public $incrementing = true;
    public $timestamps = true;

    protected $fillable = [
        'customer_id',
        'order_date',
        'order_total',
        'status',
    ];

    protected $casts = [
        'order_date' => 'datetime',
        'order_total' => 'decimal:2',
    ];

    /**
     * Relasi dengan Customer
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'customer_id', 'customer_id');
    }
}
