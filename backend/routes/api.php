<?php

use Illuminate\Http\Request;
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



// Customer menu
Route::get('/tenant', 'TenantController@index');
Route::get('/tenant/detail/{id_tenant}', 'TenantController@detail');
Route::get('/tenant/service/{id_tenant}', 'ServiceController@detail');
Route::post('/tenant/submit/', 'OrderController@add');
Route::get('/order', 'OrderController@index');
Route::get('/order/{order_id}', 'OrderController@detail');
Route::post('/order/{order_id}/finish', 'OrderController@finish');
Route::post('/order/{order_id}/rate', 'OrderController@rate');

