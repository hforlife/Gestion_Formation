<?php

namespace Database\Seeders;

use App\Models\Etudiant;
use App\Models\Formation;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EtudiantSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $formations = Formation::all();

        Etudiant::factory()->count(50)->make()->each(function($etudiant) use ($formations) {
            $etudiant->formation_id = $formations->random()->id;
            $etudiant->inscription_date = now()->subDays(rand(1, 365));
            $etudiant->status = 'active';
            $etudiant->save();
        });
    }
}
