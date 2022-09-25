<?php

namespace Database\Factories;

use App\Enums\ProductStatus;
use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use JetBrains\PhpStorm\ArrayShape;

class ProductFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Product::class;

    /**
     * @return array
     * @return array<string, mixed>
     */
    #[ArrayShape(['name' => "string", 'slug' => "string", 'price' => "float", 'stock' => "int", 'status' => "int|string", 'company_id' => "int"])]
    public function definition(): array
    {
        $name = $this->faker->unique()->name();

        return [
            'name' => $name,
            'slug' => Str::slug($name),
            'price' => $this->faker->randomFloat(2,5,100),
            'stock' => $this->faker->randomDigit(),
            'status' => ProductStatus::randomValue(),
            'company_id' => 1
        ];
    }
}
