<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ServiceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('services')->insert(
            [
                [
                    "id" => 1,
                    "tenant_id" => 1,
                    "nama" => "Isi Angin",
                    "harga" => 2000,
                ],[
                    "id" => 2,
                    "tenant_id" => 1,
                    "nama" => "Tambal Ban",
                    "harga" => 5000
                ],
            ]
        );
    }
}
