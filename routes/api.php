<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\QueryTestController;

// Customer Routes
Route::get('/customers', [CustomerController::class, 'index']);
Route::post('/customers', [CustomerController::class, 'store']);
Route::get('/customers/{id}', [CustomerController::class, 'show']);
Route::put('/customers/{id}', [CustomerController::class, 'update']);
Route::delete('/customers/{id}', [CustomerController::class, 'destroy']);

// Order Routes
Route::get('/orders', [OrderController::class, 'index']);
Route::post('/orders', [OrderController::class, 'store']);
Route::get('/orders/{id}', [OrderController::class, 'show']);
Route::put('/orders/{id}', [OrderController::class, 'update']);
Route::delete('/orders/{id}', [OrderController::class, 'destroy']);

// Query Test Routes (sesuai dengan 5 query di COMPLETE_UAS_SQL.sql)
Route::get('/queries/1', [QueryTestController::class, 'query1']);
Route::get('/queries/2', [QueryTestController::class, 'query2']);
Route::get('/queries/3', [QueryTestController::class, 'query3']);
Route::get('/queries/4', [QueryTestController::class, 'query4']);
Route::get('/queries/5', [QueryTestController::class, 'query5']);
Route::get('/queries/all', [QueryTestController::class, 'all']);
