<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Certificat extends Model
{

    protected $fillable = [
        'etudiant_id',
        'issued_at',
        'certificate_url',
    ];
}
