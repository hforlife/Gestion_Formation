<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Progression extends Model
{
    protected $fillable = [
        'etudiant_id',
        'progress',
    ];

}
