<?php

namespace App\Http\Controllers;

use App\Tenant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TenantController extends Controller
{
    public function index()
    {
        $data = Tenant::all();
        foreach ($data as $d) {
            $legits = $d->review()
            ->whereNotNull('rating')
            ->get()
            ->toArray();
            if(count($legits) > 0){
                $d->rating = array_sum(array_column($legits, "rating")) / count($legits);
            }else{
                $d->rating = 0.0;
            }
        }
        return response()->json($data);

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

    public function detail($id_tenant)
    {
        $data = [
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
        ];
        $data = Tenant::find($id_tenant);
        $legits = $data->review()
        ->whereNotNull('rating')
        ->get()
        ->toArray();

        if(count($legits) > 0){
            $data->rating = array_sum(array_column($legits, "rating")) / count($legits);
        }else{
            $data->rating = 0.0;
        }

        return response()->json($data);
    }
}
