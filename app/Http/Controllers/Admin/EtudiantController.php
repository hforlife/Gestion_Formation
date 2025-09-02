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
    public function index()
    {
        $etudiant = Etudiant::with('formation')->get();
        return Inertia::render('dashboard/Etudiant/Index', [
            'etudiants' => $etudiant,
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
            'nom' => 'required',
            'prenom' => 'required',
            'email' => 'required',
            'telephone' => 'required',
            'adresse' => 'required',
            'profession' => 'required',
            'formation_id' => 'required',
            'inscription_date' => 'required',
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
        $etudiant = Etudiant::with('formation')->find($id);

        return Inertia::render('dashboard/Etudiant/Edit', [
            'etudiant' => $etudiant,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, int $id)
    {
        //
        $request->validate([
            'nom' => 'nullable',
            'prenom' => 'nullable',
            'email' => 'nullable',
            'telephone' => 'nullable',
            'adresse' => 'nullable',
            'profession' => 'nullable',
            'formation_id' => 'nullable',
            'inscription_date' => 'nullable',
            'status' => 'nullable',
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
