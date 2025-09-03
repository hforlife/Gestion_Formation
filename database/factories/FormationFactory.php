<?php

namespace Database\Factories;

use App\Models\Formation;
use Illuminate\Database\Eloquent\Factories\Factory;

class FormationFactory extends Factory
{
    protected $model = Formation::class;

    public function definition(): array
    {
        $title = $this->faker->catchPhrase;
        $start = $this->faker->dateTimeBetween('-1 year', 'now');
        $end = $this->faker->dateTimeBetween($start, '+3 months');

        return [
            'title' => $title,
            'description' => $this->faker->paragraph,
            'start_date' => $start->format('Y-m-d'),
            'end_date' => $end->format('Y-m-d'),
            'logo_formation' => 'formations/logo_'.$this->faker->numberBetween(1,5).'.png',
        ];
    }
}
