<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use App\Models\Formation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CertificatController extends Controller
{
    //
    public function index(Request $request)
    {
         // On récupère uniquement les étudiants validés
        $perPage = $request->get('per_page', 10);

        $etudiants = Etudiant::with('formation')
            ->orderBy('created_at', 'desc')
            ->where('status', 'Valide')
            ->paginate($perPage)
            ->withQueryString();

        return Inertia::render('dashboard/Certificat/Index', [
            'etudiants' => $etudiants
        ]);
    }
}
