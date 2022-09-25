<?php

namespace Database\Factories;

use App\Enums\AddressStatus;
use App\Models\Customer;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class CustomerAddressFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'customer_id' => Customer::factory()->create()->id,
            'name' => $this->faker->unique()->name(),
            'address_text' => $this->faker->address(),
            'status' => AddressStatus::randomValue(),
        ];
    }
}
