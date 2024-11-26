<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\DonationController;
use App\Http\Controllers\EventController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test', function () {
    return response([
        'message' => 'Api is working'
    ], 200);
});

Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);
Route::get('/get/login/{id}', [AuthenticationController::class, 'getLogin']);
Route::post('/forget-password', [AuthenticationController::class, 'forgetPassword']);

// Donation routes (protected by auth middleware)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/donations', [DonationController::class, 'donasi']);
    Route::get('/donations/history', [DonationController::class, 'history']);
    Route::patch('/donations/{donation}/status', [DonationController::class, 'updateStatus']);
});

// Event routes (public)
Route::get('/events/list', [EventController::class, 'index']);
Route::get('/events/{event}', [EventController::class, 'show']);

// Event routes (protected)
Route::middleware('auth:sanctum')->group(function () {
    // Event protected routes
    Route::get('/event/history', [EventController::class, 'history']);
    Route::post('/events/register', [EventController::class, 'register']);
});

// Admin routes (tambahkan middleware admin jika diperlukan)
Route::post('/events', [EventController::class, 'store']);

Route::post('/validate-email', [EventController::class, 'validateEmail']);
