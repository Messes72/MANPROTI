<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\DonationController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\EventCategoryController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Feed\FeedController;
use App\Models\Feed;



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

// Feed routes (protected by auth middleware)
Route::get('/feeds', [FeedController::class, 'index'])->middleware('auth:sanctum');
Route::post('/feed/store', [FeedController::class, 'store'])->middleware('auth:sanctum');
Route::post('/feed/like/{feed_id}', [FeedController::class, 'likePost'])->middleware('auth:sanctum');
Route::post('/feed/comment/{feed_id}', [FeedController::class, 'comment'])->middleware('auth:sanctum'); // Untuk menambahkan komentar
Route::get('/feed/comments/{feed_id}', [FeedController::class, 'getComments'])->middleware('auth:sanctum'); // Untuk mendapatkan komentar


// Donation routes (protected by auth middleware)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/donations', [DonationController::class, 'donasi']);
    Route::get('/donations/history', [DonationController::class, 'history']);
    Route::patch('/donations/{donation}/status', [DonationController::class, 'updateStatus']);
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::post('/profile/update', [ProfileController::class, 'update']);
});

// Event routes (public)
Route::get('/events/list', [EventController::class, 'index']);
Route::get('/events/{event}', [EventController::class, 'show']);

// Event routes (protected)
Route::middleware('auth:sanctum')->group(function () {
    // Event protected routes
    Route::get('/event/history', [EventController::class, 'history']);
    Route::post('/events/register', [EventController::class, 'register']);
    Route::delete('/events/registration/{registration}', [EventController::class, 'cancelRegistration']);
    Route::post('/events/{event}/toggle-reminder', [EventController::class, 'toggleReminder']);
    Route::get('/events/{event}/share', [EventController::class, 'generateShareUrl']);
});

// Admin routes (tambahkan middleware admin jika diperlukan)
Route::post('/events', [EventController::class, 'store']);

Route::post('/validate-email', [EventController::class, 'validateEmail']);

// Public article routes
Route::get('/articles/list', [ArticleController::class, 'index']);
Route::get('/articles/{article}', [ArticleController::class, 'show']);

// Admin article routes (add middleware as needed)
Route::post('/articles', [ArticleController::class, 'store']);

Route::get('/event-categories', [EventCategoryController::class, 'index']);

// Event category routes (admin only)
Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('/event-categories', [EventCategoryController::class, 'store']);
    Route::put('/event-categories/{category}', [EventCategoryController::class, 'update']);
    Route::delete('/event-categories/{category}', [EventCategoryController::class, 'destroy']);
});

// Admin routes untuk event
Route::middleware(['auth:sanctum'])->group(function () {
    Route::put('/events/{event}', [EventController::class, 'update']);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthenticationController::class, 'logout']);
});
