<?php

use App\Http\Controllers\SiteController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;


Route::get('/', [SiteController::class,'home'])->name('home');

Route::get('/course', [SiteController::class,'course'])->name('course');

// Route::get('/detail', [SiteController::class,'detail'])->name('detail');
Route::get('/detail/{id}', [SiteController::class, 'detail'])->name('detail');
Route::post('/detail/{id}/register', [SiteController::class, 'register'])->name('detail.register');

Route::get('/about', [SiteController::class,'about'])->name('about');

Route::get('/contact', [SiteController::class,'contact'])->name('contact');
Route::post('/contact', [SiteController::class, 'send'])->name('contact.send');

