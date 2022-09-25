<?php

namespace App\Models;

use App\Filters\OrderGetFilters;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Order extends Model
{
    use HasFactory;

    /**
     * The model's default values for attributes.
     *
     * @var array<string, mixed>
     */
    protected $attributes = [
        'total' => 0,
        'shipping_date' => '2022-09-24 18:08:52'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'id' => 'int',
        'customer_id' => 'int',
        'company_id' => 'int',
        'status' => 'int',
        'total' => 'float',
        'customer_address_id' =>'int',
        'code'=>'string',
        'updated_at' => 'datetime',
        'created_at' => 'datetime',
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'customer_id',
        'company_id',
        'shipping_status',
        'shipping_date',
        'customer_address_id',
        'code',
        'status',
        'total',
    ];

    /**
     * @return HasMany
     */
    public function orderProduct(): HasMany
    {
        return $this->hasMany(OrderProduct::class);
    }

    /**
     * @return BelongsTo
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    /**
     * @return BelongsTo
     */
    public function customerAddress(): BelongsTo
    {
        return $this->belongsTo(CustomerAddress::class);
    }

    /**
     * @param $query
     * @param OrderGetFilters $filters
     * @return Builder
     */
    public function scopeFilter($query, OrderGetFilters $filters): Builder
    {
        return $filters->apply($query);
    }
}
