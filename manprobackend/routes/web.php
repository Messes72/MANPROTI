<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\EventManagementController;
use App\Http\Controllers\Admin\DonationManagementController;
use App\Http\Controllers\Admin\ArticleManagementController;

/*
|--------------------------------------------------------------------------
| Website Routes
|--------------------------------------------------------------------------
|
| Di sini adalah tempat untuk mendaftarkan route website utama.
| Route-route ini bisa diakses oleh semua pengunjung website.
|
*/

Route::get('/', function () {
    return view('welcome');
})->name('home');

/*
|--------------------------------------------------------------------------
| Admin Panel Routes
|--------------------------------------------------------------------------
|
| Semua route untuk admin panel dimulai dengan prefix 'admin'
| Contoh: /admin/login, /admin/dashboard, dll
|
*/
Route::prefix('admin')->name('admin.')->group(function () {

    /*
    |--------------------------------------------------------------------------
    | Admin Authentication Routes
    |--------------------------------------------------------------------------
    |
    | Route untuk login, register, dan logout admin
    | - GET  /admin/login    -> Halaman login
    | - POST /admin/login    -> Proses login
    | - GET  /admin/register -> Halaman register
    | - POST /admin/register -> Proses register
    | - POST /admin/logout   -> Proses logout
    |
    */
    Route::controller(AdminController::class)->group(function () {
        // Authentication Routes
        Route::get('/login', 'login')->name('login');
        Route::post('/login', 'doLogin')->name('doLogin');
        Route::get('/register', 'register')->name('register');
        Route::post('/register', 'doRegister')->name('doRegister');
        Route::post('/logout', 'logout')->name('logout');

        // Dashboard Route
        Route::get('/dashboard', 'dashboard')->name('dashboard');
    });

    /*
    |--------------------------------------------------------------------------
    | Event Management Routes
    |--------------------------------------------------------------------------
    |
    | Route untuk mengelola event
    | - CRUD Event
    | - Kategori Event
    | - Pendaftaran Event
    |
    */
    Route::prefix('events')->name('events.')->controller(EventManagementController::class)->group(function () {
        // Event CRUD
        // Daftar event
        Route::get('/', 'index')->name('index');
        // Form tambah event
        Route::get('/create', 'create')->name('create');
        // Simpan event baru
        Route::post('/', 'store')->name('store');
        // Form edit event
        Route::get('/{event}/edit', 'edit')->name('edit');
        // Update event
        Route::put('/{event}', 'update')->name('update');
        // Hapus event
        Route::delete('/{event}', 'destroy')->name('destroy');
        // Update status event
        Route::post('/{event}/update-status', 'updateStatus')->name('update-status');

        // Event Categories
        // Daftar kategori
        Route::get('/categories', 'categories')->name('categories');
        // Tambah kategori
        Route::post('/categories', 'storeCategory')->name('categories.store');
        // Update kategori
        Route::put('/categories/{category}', 'updateCategory')
            ->name('categories.update');
        // Hapus kategori
        Route::delete('/categories/{category}', 'destroyCategory')
            ->name('categories.destroy');

        // Event Registrations
        // Daftar pendaftaran
        Route::get('/registrations', 'registrations')->name('registrations');
        // Update status pendaftaran
        Route::post('/registrations/{registration}/update-status', 'updateRegistrationStatus')
            ->name('registrations.update-status');
    });

    /*
    |--------------------------------------------------------------------------
    | Donation Management Routes
    |--------------------------------------------------------------------------
    |
    | Route untuk mengelola donasi
    | - Daftar & Status Donasi
    | - Jenis Donasi
    |
    */
    Route::prefix('donations')->name('donations.')->controller(DonationManagementController::class)->group(function () {
        // Donation Management
        Route::get('/', 'index')->name('index');
        // Update status donasi
        Route::put('/{donation}/update-status', 'updateStatus')->name('update-status');

        // Donation Types
        Route::get('/types', 'types')->name('types');
        // Tambah jenis donasi
        Route::post('/types', 'storeType')->name('types.store');
        // Update jenis donasi
        Route::put('/types/{type}', 'updateType')->name('types.update');
        // Hapus jenis donasi
        Route::delete('/types/{type}', 'destroyType')->name('types.destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | Shipping Methods Routes
    |--------------------------------------------------------------------------
    |
    | Route untuk mengelola metode pengiriman donasi
    |
    */
    Route::prefix('shipping-methods')->name('shipping-methods.')
        ->controller(DonationManagementController::class)->group(function () {
            // Daftar metode pengiriman
            Route::get('/', 'shippingMethods')->name('index');
            // Tambah metode pengiriman
            Route::post('/', 'storeShippingMethod')->name('store');
            // Update metode pengiriman
            Route::put('/{method}', 'updateShippingMethod')->name('update');
            // Hapus metode pengiriman
            Route::delete('/{method}', 'destroyShippingMethod')->name('destroy');
        });

    // Article Management Routes
    Route::prefix('articles')->name('articles.')->group(function () {
        Route::get('/', [ArticleManagementController::class, 'index'])->name('index');
        Route::get('/create', [ArticleManagementController::class, 'create'])->name('create');
        Route::post('/', [ArticleManagementController::class, 'store'])->name('store');
        Route::get('/{article}/edit', [ArticleManagementController::class, 'edit'])->name('edit');
        Route::put('/{article}', [ArticleManagementController::class, 'update'])->name('update');
        Route::delete('/{article}', [ArticleManagementController::class, 'destroy'])->name('destroy');
    });
});
