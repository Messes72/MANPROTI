<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $fillable = [
        'title',
        'content',
        'image',
        'date'
    ];

    public function registrations()
    {
        return $this->hasMany(EventRegistration::class);
    }
}
