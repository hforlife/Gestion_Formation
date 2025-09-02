<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Formation;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class FormationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $formations = Formation::with('formateur')->get();

        return Inertia::render('dashboard/Formation/Index', [
            'formations' => $formations
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // Récupérer uniquement les utilisateurs ayant le rôle 'formateur'
        $formateurs = User::role('formateur')->get();

        return Inertia::render('dashboard/Formation/Create', [
            'formateurs' => $formateurs
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'user_id' => 'required|exists:users,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:5048',
        ]);

        $formation = new Formation();
        $formation->title = $request->title;
        $formation->description = $request->description;
        $formation->start_date = $request->start_date;
        $formation->end_date = $request->end_date;
        $formation->user_id = $request->user_id;

        // Gestion de l'image
        if ($request->hasFile('image')) {
            $formation->image = $request->file('image')->store('formations', 'public');
        }

        $formation->save();

        return redirect()->route('formation.index')->with('status', 'Ajout effectué avec succès.');
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $formation = Formation::with('formateur')->findOrFail($id);

        return Inertia::render('dashboard/Formation/Show', [
            'formation' => $formation
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(int $id)
    {
        $formation = Formation::findOrFail($id);
        $formateurs = User::role('formateur')->get();

        return Inertia::render('dashboard/Formation/Edit', [
            'formation' => $formation,
            'formateurs' => $formateurs
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, int $id)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'user_id' => 'required|exists:users,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:5048',
        ]);

        $formation = Formation::findOrFail($id);
        $formation->title = $request->title;
        $formation->description = $request->description;
        $formation->start_date = $request->start_date;
        $formation->end_date = $request->end_date;
        $formation->user_id = $request->user_id;

        // Gestion de l'image
        if ($request->hasFile('image')) {
            // Supprimer l'ancienne image si elle existe
            if ($formation->image) {
                Storage::disk('public')->delete($formation->image);
            }
            $formation->image = $request->file('image')->store('formations', 'public');
        }

        $formation->save();

        return redirect()->route('formation.index')->with('status', 'Modification effectuée avec succès.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id)
    {
        $formation = Formation::findOrFail($id);

        // Supprimer l'image si elle existe
        if ($formation->image) {
            Storage::disk('public')->delete($formation->image);
        }

        $formation->delete();

        return redirect()->route('formation.index')->with('status', 'Formation supprimée avec succès.');
    }
}
