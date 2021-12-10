<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Tenant extends Model
{
    protected $table = "tenants";
    protected $fillable = [
        'id',
        'user_id',
        'nama',
        'deskripsi',
        'photo_url'
    ];

    public function review(){
        return $this->hasMany(Order::class, 'tenant_id', 'id');
    }
}
