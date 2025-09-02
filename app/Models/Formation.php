<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Formation extends Model
{
    protected $fillable = [
        'title',
        'description',
        'start_date',
        'end_date',
        'user_id',
        'image',
    ];

    // Relation avec le modèle User (formateur)
    public function formateur()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
