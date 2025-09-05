<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use App\Models\Formation;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class DashboardController extends Controller
{
    public function index()
    {
        // Récupération des statistiques de base
        $totalEtudiants = Etudiant::count();
        $etudiantsValides = Etudiant::where('status', 'Validé')->count();
        $etudiantsEnCours = Etudiant::where('status', 'En Cours')->count();
        $etudiantsRejetes = Etudiant::where('status', 'Rejété')->count();
        $totalFormations = Formation::count();
        
        // Calcul du taux de validation
        $tauxValidation = $totalEtudiants > 0 ? round(($etudiantsValides / $totalEtudiants) * 100, 2) : 0;

        // Dernières inscriptions avec la formation
        $recentEtudiants = Etudiant::with('formation')
            ->latest()
            ->take(8)
            ->get(['id', 'nom', 'prenom', 'status', 'formation_id', 'created_at']);

        // Évolution mensuelle des 6 derniers mois
        $evolutionMensuelle = [];
        for ($i = 5; $i >= 0; $i--) {
            $date = Carbon::now()->subMonths($i);
            $startOfMonth = $date->copy()->startOfMonth();
            $endOfMonth = $date->copy()->endOfMonth();

            $inscriptions = Etudiant::whereBetween('created_at', [$startOfMonth, $endOfMonth])->count();
            $validations = Etudiant::where('status', 'Validé')
                ->whereBetween('created_at', [$startOfMonth, $endOfMonth])
                ->count();

            $evolutionMensuelle[] = [
                'mois' => $date->format('M Y'),
                'inscriptions' => $inscriptions,
                'validations' => $validations,
            ];
        }

        return Inertia::render('dashboard/Dashboard/Index', [
            'stats' => [
                'totalEtudiants' => $totalEtudiants,
                'etudiantsValides' => $etudiantsValides,
                'etudiantsEnCours' => $etudiantsEnCours,
                'etudiantsRejetes' => $etudiantsRejetes,
                'totalFormations' => $totalFormations,
                'tauxValidation' => $tauxValidation,
            ],
            'recentEtudiants' => $recentEtudiants,
            'evolutionMensuelle' => $evolutionMensuelle,
        ]);
    }
}