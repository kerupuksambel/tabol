<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index()
    {
        $data = [
            [
                "id" => 1,
                "tenant_nama" => "Tambal Ban 1",
                "service_id" => 1,
                "status" => "dipesan",
                "lat" => -8.073240,
                "long" => 111.907340,
                "created_at" => Carbon::now()->format("Y-m-d H:i:s"),
                "updated_at" => now(),
            ]
        ];

        return response()->json($data);
    }

    public function add()
    {
        return response()->json(["success" => 1]);
    }

    public function rate($order_id)
    {
        return response()->json(["success" => 1]);
    }


    public function detail($order_id)
    {
        return response()->json([
            "id" => 1,
            "tenant_nama" => "Tambal Ban 1",
            "service_id" => 1,
            "service_nama" => "Tambal Ban",
            "harga" => 5000,
            "status" => "dipesan",
            "lat" => -8.073240,
            "long" => 111.907340,
            "created_at" => Carbon::now()->format("Y-m-d H:i:s"),
            "updated_at" => now(),
        ]);
    }

    public function finish($order_id)
    {
        return response()->json(["success" => 1]);
    }
}
