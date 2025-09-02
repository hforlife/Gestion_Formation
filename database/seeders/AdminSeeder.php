<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $AdminRole = Role::firstOrCreate(['name' => 'admin']);
        $AdminRole->syncPermissions(Permission::all());

        $admins = [
            [
                'name' => 'Super Admin',
                'username' => 'admin',
                'email' => 'admin@doucsoft.com',
                'password' => env('ADMIN_PASSWORD', 'password'),
            ],
            [
                'name' => 'Abdoulaye Y HAIDARA',
                'username' => 'abdoul',
                'email' => 'abdoulayeyoro.haidara@doucsoft.com',
                'password' => env('ADMIN1_PASSWORD', 'password'),
            ],
            [
                'name' => 'Moussa DOUCOURE',
                'username' => 'doucsoft',
                'email' => 'moussdouc@doucsoft.tech',
                'password' => env('ADMIN2_PASSWORD', 'password'),
            ],
            [
                'name' => 'Malle MAGASSA',
                'username' => 'kizza',
                'email' => 'mallemagass@doucsoft.tech',
                'password' => env('ADMIN3_PASSWORD', 'password'),
            ],
        ];

        foreach ($admins as $data) {
            $user = User::updateOrCreate(
                ['email' => $data['email']],
                [
                    'name' => $data['name'],
                    'username' => $data['username'],
                    'password' => bcrypt($data['password']),
                    'email_verified_at' => now(),
                    'remember_token' => Str::random(10),
                ]
            );

            $user->assignRole($AdminRole);
        }
    }
}
