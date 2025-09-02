<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CertificatController extends Controller
{
    //
    public function index()
    {
         // On récupère uniquement les étudiants validés
        $etudiants = Etudiant::with('formation')
            ->where('status', 'Validé')
            ->get();

        return Inertia::render('dashboard/Certificat/Index', [
            'etudiants' => $etudiants
        ]);
    }
}
