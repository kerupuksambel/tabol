<?php

namespace App\Http\Controllers;

use App\Service;
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

        $data = Service::where('tenant_id', $id_tenant)->get();

        return response()->json($data);
    }
}
