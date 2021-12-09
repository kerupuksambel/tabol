<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function add()
    {
        return response()->json(["success" => 1]);
    }

    public function rate($order_id)
    {

    }

    public function index()
    {

    }

    public function detail($order_id)
    {

    }

    public function finish($order_id)
    {

    }
}
