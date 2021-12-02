<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TenantController extends Controller
{
    public function index()
    {
        return response()->json([
            [
                'id' => 1,
                'user_id' => 1,
                'nama' => 'Tambal Ban 1',
                'deskripsi' => 'Jasa tambal ban daerah Bandung, Tulungagung, Jawa Timur',
                'photo_url' => 'https://via.placeholder.com/150',
                'rating' => 3.2
            ],
            [
                'id' => 2,
                'user_id' => 2,
                'nama' => 'Tambal Ban kedua',
                'deskripsi' => 'Jasa tambal ban daerah Besuki, Tulungagung, Jawa Timur',
                'photo_url' => 'https://via.placeholder.com/150/',
                'rating' => 4.3
            ],
        ]);
    }

    public function detail($tenant_id)
    {
        
    }

    public function service($tenant_id)
    {
        
    }
}
