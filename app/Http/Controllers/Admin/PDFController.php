<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use App\Models\Formation;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PDFController extends Controller
{
    // Générer PDF
    public function PDF($userId, $formId)
    {
        $etudiant = Etudiant::findOrFail($userId);
        $formation = Formation::findOrFail($formId);

        // Données pour le certificat
        $formationLogoPath = $formation->logo_formation
            ? storage_path('storage/icones_formation/' . $formation->logo_formation)
            : public_path('asset/img/logo_formaplus.png');

        $data = [
            'debut' => $formation->start_date,
            'fin' => $formation->end_date,
            'nom' => $etudiant->nom . ' ' . $etudiant->prenom,
            'texte2' => 'A suivi du ' . $formation->start_date . ' au ' . $formation->end_date . ' la formation :',
            'formationName' => $formation->title,
            'formationLogo' => $formation->logo_formation,
        ];

        // Génération du PDF avec une vue Blade
        $pdf = Pdf::loadView('pdf.certificat', $data)->setPaper('a4', 'landscape');

        return $pdf->stream('certificat_' . $etudiant->id . '.pdf');
    }
    // Nouvelle méthode pour la version navigateur
    public function show($userId, $formId)
    {
        $etudiant = Etudiant::findOrFail($userId);
        $formation = Formation::findOrFail($formId);

        return Inertia::render('dashboard/Certificat/CertificatePrint', [
            'etudiant' => $etudiant,
            'formation' => $formation
        ]);
    }
}
