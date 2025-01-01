<?php

use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Auth\LoginController ;
use App\Http\Controllers\Api\Auth\LogoutController ;
use App\Http\Controllers\Api\Auth\RegisterController ;
use App\Http\Controllers\Api\Auth\PasswordResetController ;





/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/


Route::post('login',App\Http\Controllers\Api\Auth\LoginController::class );
Route::post('logout',App\Http\Controllers\Api\Auth\LogoutController::class );
Route::post('register',App\Http\Controllers\Api\Auth\RegisterController::class );
Route::post('password/email',[App\Http\Controllers\Api\Auth\PasswordResetController::class,'sendResetLinkEmail' ]);
Route::post('password/reset',[App\Http\Controllers\Api\Auth\PasswordResetController::class,'reset'] )->name('password.reset');





Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
});
