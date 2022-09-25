<?php

use App\Http\Controllers\Api\Auth\LoginController;
use App\Http\Controllers\Api\OrderController;
use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::controller(LoginController::class)->prefix('/auth')->group(function () {
    Route::post('/login', 'login');
});

Route::middleware('auth:api-customers')->controller(OrderController::class)->prefix('/order')->group(function () {
    Route::post('/', 'index');
    Route::post('/add', 'add');
    Route::post('/update', 'update');
});
