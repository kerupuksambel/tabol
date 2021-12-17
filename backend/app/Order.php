<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $table = 'orders';
    protected $fillable = [
        'service_id',
        'tenant_id',
        'status',
        'lat',
        'long',
        'rating',
        'created_at',
        'updated_at',
        'user_id'
    ];

    protected $dateFormat = "Y-m-d H:i:s";

    public function service(){
        return $this->hasOne(Service::class, 'id', 'service_id');
    }

    public function tenant(){
        return $this->hasOne(Tenant::class, 'id', 'tenant_id');
    }
}
