<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\EventManagementController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application.
| These routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group.
|
*/

// Landing Page
Route::get('/', function () {
    return view('welcome');
});

/*
|--------------------------------------------------------------------------
| Admin Routes
|--------------------------------------------------------------------------
*/
Route::prefix('admin')->name('admin.')->group(function () {
    
    // Authentication Routes
    Route::controller(AdminController::class)->group(function () {
        Route::get('/login', 'login')->name('login');
        Route::post('/login', 'doLogin')->name('doLogin');
        Route::get('/register', 'register')->name('register');
        Route::post('/register', 'doRegister')->name('doRegister');
        Route::post('/logout', 'logout')->name('logout');
        Route::get('/dashboard', 'dashboard')->name('dashboard');
    });

    // Event Management Routes
    Route::prefix('events')->name('events.')->controller(EventManagementController::class)->group(function () {
        // Event CRUD Routes
        Route::get('/', 'index')->name('index');
        Route::get('/create', 'create')->name('create');
        Route::post('/', 'store')->name('store');
        Route::get('/{event}/edit', 'edit')->name('edit');
        Route::put('/{event}', 'update')->name('update');
        Route::delete('/{event}', 'destroy')->name('destroy');
        Route::post('/{event}/update-status', 'updateStatus')->name('update-status');

        // Event Categories Routes
        Route::get('/categories', 'categories')->name('categories');
        Route::post('/categories', 'storeCategory')->name('categories.store');
        Route::put('/categories/{category}', 'updateCategory')->name('categories.update');
        Route::delete('/categories/{category}', 'destroyCategory')->name('categories.destroy');

        // Event Registration Routes
        Route::get('/registrations', 'registrations')->name('registrations');
        Route::post('/registrations/{registration}/update-status', 'updateRegistrationStatus')
            ->name('registrations.update-status');
    });

    // Protected Admin Routes
    Route::middleware(['auth', 'admin'])->group(function () {
        // Add any additional protected routes here
    });
});
