<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Enums\CustomerRoles;
use App\Models\Company;
use App\Models\Customer;
use App\Models\CustomerAddress;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Company::factory(1)->create();
        Customer::factory(1)->create([
            'email' => 'admin@example.org',
            'role'  => CustomerRoles::ADMIN,
            'password' => Hash::make('123456') // password
        ]);
        Customer::factory(1)->create([
            'email' => 'test_user@example.org',
        ]);
        CustomerAddress::factory(1)->create([
            'customer_id' => 2
        ]);
        CustomerAddress::factory(3)->create();
        Product::factory(100)->create();
    }
}
