<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\Customer;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        
        // Get all customer IDs
        $customerIds = Customer::pluck('customer_id')->toArray();
        
        if (empty($customerIds)) {
            $this->command->error('Tidak ada customer. Jalankan CustomerSeeder terlebih dahulu!');
            return;
        }
        
        // Generate 1000 orders
        $statuses = ['pending', 'paid', 'canceled', 'delivered'];
        
        for ($i = 1; $i <= 1000; $i++) {
            Order::create([
                'customer_id' => $faker->randomElement($customerIds),
                'order_date' => $faker->dateTimeBetween('-6 months', 'now'),
                'order_total' => $faker->randomFloat(2, 10000, 500000),
                'status' => $faker->randomElement($statuses),
            ]);
        }
    }
}
