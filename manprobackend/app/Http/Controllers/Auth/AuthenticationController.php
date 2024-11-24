<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterRequest;
use App\Http\Requests\LoginRequest;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
class AuthenticationController extends Controller
{
    public function register(RegisterRequest $request)
    {
        $request->validated();

        $userData = [
            'nama_lengkap' => $request->nama_lengkap,
            'username' => $request->username,
            'email' => $request->email,
            'kota_asal' => $request->kota_asal,
            'no_telpon' => $request->no_telpon,
            'password' => Hash::make($request->password),
        ];

        $user = User::create($userData);
        $token = $user->createToken('manprobackend')->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token
        ], 201);
    }

    public function login(LoginRequest $request)
    {
        $request->validated();

        $user = User::whereUsername($request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response([
                'message' => 'Username atau password salah'
            ], 422);
        }

        $token = $user->createToken('manprobackend')->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token
        ], 200);
    }
}
