<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ServiceController extends Controller
{
    public function detail($id_tenant)
    {
        $data = [
            [
                "id" => 1,
                "id_tenant" => 1,
                "nama" => "Isi Angin",
                "harga" => 2000,
            ],[
                "id" => 2,
                "id_tenant" => 1,
                "nama" => "Tambal Ban",
                "harga" => 5000
            ],
        ];

        return response()->json($data);
    }
}
