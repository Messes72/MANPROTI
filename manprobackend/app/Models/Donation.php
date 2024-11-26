<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Donation extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'type',
        'quantity',
        'shipping_method',
        'status',
        'notes'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
