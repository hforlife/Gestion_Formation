<?php

namespace Database\Seeders;

use App\Models\Formation;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FormationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        $formateurs = User::all();

        // Création de 10 formations
        Formation::factory()->count(10)->make()->each(function($formation) use ($formateurs) {
            $formation->user_id = $formateurs->random()->id;
            $formation->image = 'formations/'.$formation->title.'.png'; // image fictive
            $formation->save();
        });
    }
}
