<?php

namespace App\Http\Controllers;

use App\Order;
use App\Tenant;
use Carbon\Carbon;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index($user_id)
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

        $data = Order::where('user_id', $user_id)
        ->orderBy('created_at', 'DESC')->get()->toArray();
        foreach ($data as $idx => $d) {
            $data[$idx]['tenant_nama'] = Tenant::find($data[$idx]['tenant_id'])->nama;
            $data[$idx]['created_at'] = Carbon::parse($data[$idx]['created_at'])->format("Y-m-d H:i:s");
            $data[$idx]['updated_at'] = Carbon::parse($data[$idx]['updated_at'])->format("Y-m-d H:i:s");
        }

        return response()->json($data);
    }

    public function add(Request $request)
    {
        Order::create([
            "service_id" => $request->service_id,
            "tenant_id" => $request->tenant_id,
            "user_id" => $request->user_id,
            "status" => "dipesan",
            "lat" => $request->lat,
            "long" => $request->long
        ]);

        return response()->json(["success" => 1]);
    }

    public function rate(Request $request, $order_id)
    {
        $order = Order::findOrFail($order_id);
        $order->rating = $request->rating;
        $order->save();

        return response()->json(["success" => 1]);
    }


    public function detail($order_id)
    {
        $data = Order::findOrFail($order_id);
        return response()->json([
            "id" => $data->id,
            "tenant_nama" => $data->tenant->nama,
            "service_id" => $data->service_id,
            "service_nama" => $data->service->nama,
            "harga" => $data->service->harga,
            "status" => $data->status,
            "lat" => $data->lat,
            "long" => $data->long,
            "user_id" => $data->user_id,
            "rating" => $data->rating,
            "created_at" => Carbon::parse($data->created_at)->format("Y-m-d H:i:s"),
            "updated_at" => Carbon::parse($data->updated_at)->format("Y-m-d H:i:s"),
        ]);
    }

    public function finish($order_id)
    {
        $order = Order::findOrFail($order_id);
        $order->status = "selesai";
        $order->save();

        return response()->json(["success" => 1]);
    }
}
