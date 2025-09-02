<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Etudiant extends Model
{
    protected $fillable = [
        'nom',
        'prenom',
        'email',
        'telephone',
        'adresse',
        'profession',
        'formation_id',
        'inscription_date',
        'status',
    ];

    public function formation()
    {
        return $this->belongsTo(Formation::class, 'formation_id');
    }
}
