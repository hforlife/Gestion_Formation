<?php

namespace App\Http\Controllers;

use App\Models\Formation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\ContactMail;
use App\Models\Etudiant;
use Inertia\Inertia;

class SiteController extends Controller
{
    //Page d'accueil
    public function home()
    {
        $formation = Formation::latest()->take(6)->get();
        return Inertia::render('site/index', [
            'formations' => $formation
        ]);
    }

    // Page des formations
    public function course()
    {
        $formations = Formation::paginate(6); // 6 par page

        return Inertia::render('site/course', [
            'formations' => $formations,
        ]);
    }


    //Page de detail des formations
    public function detail($id)
    {
        $formation = Formation::with('formateur')->findOrFail($id);

        // Récupérez d'autres formations (excluant celle en cours)
        $otherFormations = Formation::where('id', '!=', $id)
            ->inRandomOrder()
            ->limit(4)
            ->get();

        return Inertia::render('site/detail', [
            'formation' => $formation,
            'otherFormations' => $otherFormations,
        ]);
    }

    // Ajoutez une méthode pour gérer les inscriptions
    public function register(Request $request, $id)
    {
        $formation = Formation::findOrFail($id);

        // Validez les données du formulaire si nécessaire
        $validated = $request->validate([
            // règles de validation
            'nom' => 'required|string|max:255',
            'prenom' => 'required|string|max:255',
            'email' => 'nullable|email',
            'telephone' => 'nullable|string|max:255',
            'adresse' => 'nullable|string|max:255',
            'profession' => 'nullable|string|max:255',
        ]);

        $user = new Etudiant();
        $user->nom = $request->nom;
        $user->prenom = $request->prenom;
        $user->email = $request->email;
        $user->telephone = $request->telephone;
        $user->adresse = $request->adresse;
        $user->profession = $request->profession;
        $user->formation_id = $formation->id;
        $user->save();
        // Logique d'inscription ici
        // Exemple: auth()->user()->formations()->attach($formation->id);

        return redirect()->back()->with('success', 'Inscription réussie !');
    }

    //Page A Propos
    public function about()
    {
        return Inertia::render('site/about');
    }

    //Page de contact
    public function contact()
    {
        return Inertia::render('site/contact');
    }

    public function send(Request $request)
    {
        $validated = $request->validate([
            'email' => 'required|email',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:2000',
        ]);

        Mail::to(config('mail.from.address'))->send(new ContactMail($validated));

        return back()->with('success', 'Votre message a été envoyé avec succès !');
    }
}
