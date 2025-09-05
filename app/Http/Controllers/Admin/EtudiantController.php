<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Etudiant;
use App\Models\Formation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class EtudiantController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $perPage = $request->get('per_page', 10);

        $etudiants = Etudiant::with('formation')
            ->orderBy('created_at', 'desc')
            ->paginate($perPage)
            ->withQueryString();

        return Inertia::render('dashboard/Etudiant/Index', [
            'etudiants' => $etudiants,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $formations = Formation::all();
        return Inertia::render('dashboard/Etudiant/Create', [
            'formations' => $formations,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $request->validate([
            'nom' => 'required|string|max:255',
            'prenom' => 'required|string|max:255',
            'email' => 'required|email',
            'telephone' => 'required|string|max:255',
            'adresse' => 'required|string|max:255',
            'profession' => 'required|string|max:255',
            'formation_id' => 'required|exists:formation_id',
            'inscription_date' => 'required|date',
            'status' => 'required',
        ]);

        $user = new Etudiant();
        $user->nom = $request->nom;
        $user->prenom = $request->prenom;
        $user->email = $request->email;
        $user->telephone = $request->telephone;
        $user->adresse = $request->adresse;
        $user->profession = $request->profession;
        $user->formation_id = $request->formation_id;
        $user->inscription_date = $request->inscription_date;
        $user->status = $request->status;
        $user->save();

        return redirect()->route('etudiant.index')->with('status', 'Ajout effectué avec succès.');
    }


    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:En Cours,Validé,Rejété',
        ]);

        $etudiant = Etudiant::findOrFail($id);
        $etudiant->status = $request->status;
        $etudiant->save();

        return back()->with('success', 'Statut mis à jour avec succès.');
    }


    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        //
        $formations = Formation::all();
        $etudiant = Etudiant::with('formation')->find($id);
        return Inertia::render('dashboard/Etudiant/Show', [
            'formations' => $formations,
            'etudiant' => $etudiant,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(int $id)
    {
        $etudiant = Etudiant::with('formation')->findOrFail($id);
        $formations = Formation::all();

        return Inertia::render('dashboard/Etudiant/Edit', [
            'etudiant' => $etudiant,
            'formations' => $formations
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, int $id)
    {
        //
        $request->validate([
            'nom' => 'required|string|max:255',
            'prenom' => 'required|string|max:255',
            'email' => 'required|email',
            'telephone' => 'required|string|max:255',
            'adresse' => 'required|string|max:255',
            'profession' => 'required|string|max:255',
            'formation_id' => 'required|exists:formations,id',
            'inscription_date' => 'required|date',
            'status' => 'required',
        ]);

        $user = Etudiant::findOrFail($id);
        $user->nom = $request->nom ?? $user->nom;
        $user->prenom = $request->prenom ?? $user->prenom;
        $user->email = $request->email ?? $user->email;
        $user->telephone = $request->telephone ?? $user->telephone;
        $user->adresse = $request->adresse ?? $user->adresse;
        $user->profession = $request->profession ?? $user->profession;
        $user->formation_id = $request->formation_id ?? $user->formation_id;
        $user->inscription_date = $request->inscription_date ?? $user->inscription_date;
        $user->status = $request->status ?? $user->status;
        $user->save();

        return redirect()->route('etudiant.index')->with('status', 'Modification effectué avec succès.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id)
    {
        $etudiant = Etudiant::findOrFail($id);

        $etudiant->delete();

        return redirect()->route('etudiant.index')->with('status', 'Etudiant supprimée avec succès.');
    }
}
