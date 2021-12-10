<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TenantSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('tenants')->insert([
            [
                'id' => 1,
                'user_id' => 1,
                'nama' => 'Tambal Ban 1',
                'deskripsi' => 'Jasa tambal ban daerah Bandung, Tulungagung, Jawa Timur',
                'photo_url' => 'https://via.placeholder.com/150',
            ],
            [
                'id' => 2,
                'user_id' => 2,
                'nama' => 'Tambal Ban kedua',
                'deskripsi' => 'Jasa tambal ban daerah Besuki, Tulungagung, Jawa Timur',
                'photo_url' => 'https://via.placeholder.com/150/'
            ]
        ]);
    }
}
