<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            [
                "name" => "Ammar Alifian Fahdan",
                "email" => "ammar@mail.id",
                "password" => bcrypt("password"),
            ],
            [
                "name" => "User Lainnya",
                "email" => "user@mail.id",
                "password" => bcrypt("123456"),
            ],
        ]);
    }
}
