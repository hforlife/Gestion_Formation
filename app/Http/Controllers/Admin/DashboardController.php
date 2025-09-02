<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use App\Models\Formation;
use Inertia\Inertia;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    //
    public function index()
    {
        // Récupération des statistiques
        $totalEtudiants = Etudiant::count();
        $etudiantsValides = Etudiant::where('status', 'Validé')->count();
        $totalFormations = Formation::count();

        // On peut aussi récupérer les dernières inscriptions
        $recentEtudiants = Etudiant::latest()->take(5)->get(['id', 'nom', 'prenom', 'status', 'formation_id']);

        // Retour vers la vue Inertia
        return Inertia::render('dashboard/Dashboard/Index', [
            'stats' => [
                'totalEtudiants' => $totalEtudiants,
                'etudiantsValides' => $etudiantsValides,
                'totalFormations' => $totalFormations,
            ],
            'recentEtudiants' => $recentEtudiants,
        ]);
    }
}
