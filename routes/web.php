<?php

use App\Http\Controllers\Admin\CertificatController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\EtudiantController;
use App\Http\Controllers\Admin\FormationController;
use App\Http\Controllers\Admin\PDFController;
use App\Http\Controllers\Admin\RoleController;
use App\Http\Controllers\Admin\UserController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;



Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard')->middleware(['auth', 'verified']);

Route::resource('/formation', FormationController::class)->middleware(['auth', 'verified']);
Route::resource('/etudiant', EtudiantController::class)->middleware(['auth', 'verified']);
Route::put('/etudiant/{id}/status', [\App\Http\Controllers\Admin\EtudiantController::class, 'updateStatus'])
    ->name('etudiant.updateStatus');
Route::resource('/certificat', CertificatController::class)->middleware(['auth', 'verified']);
Route::get('/certificat/{userId}/{formId}/generate', [PDFController::class, 'PDF'])->name('pdf.generate');
Route::resource('/user', UserController::class)->middleware(['auth', 'verified']);
Route::resource('/role', RoleController::class)->middleware(['auth', 'verified']);


require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
require __DIR__.'/site.php';
