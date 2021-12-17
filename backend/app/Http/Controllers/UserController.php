<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function login(Request $request)
    {
        $user = User::where('email', $request->email)
        ->get();

        if(count($user) > 0){
            $user = $user[0];
        }else{
            return response()->json(["success" => FALSE]);
        }

        if(Hash::check($request->password, $user->password)){
            return response()->json(['success' => TRUE, 'id' => $user->id]);
        }else{
            return response()->json(["success" => FALSE]);
        }
    }
}
