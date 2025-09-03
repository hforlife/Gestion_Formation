<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        // Création d'un admin
        User::create([
            'name' => 'Abdoulaye DIOP',
            'username' => 'abdoulaye',
            'email' => 'user@example.tech',
            'password' => 'password', // automatiquement hashé grâce au cast
            'avatar' => 'avatars/default.png',
        ]);

        // Création de plusieurs formateurs
        User::factory()->count(5)->create();
    }
}
