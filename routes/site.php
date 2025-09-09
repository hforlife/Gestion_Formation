<?php

use App\Http\Controllers\SiteController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;


Route::get('/', [SiteController::class,'home'])->name('home');

Route::get('/course', [SiteController::class,'course'])->name('course');

Route::get('/detail', [SiteController::class,'detail'])->name('detail');

Route::get('/about', [SiteController::class,'about'])->name('about');

Route::get('/contact', [SiteController::class,'contact'])->name('contact');
