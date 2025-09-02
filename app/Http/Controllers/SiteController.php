<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class SiteController extends Controller
{
    //Page d'accueil
    public function home(){
        return Inertia::render('site/index');
    }

    //Page des formations
    public function course(){
        return Inertia::render('site/course');
    }

    //Page de detail des formations
    public function detail(){
        return Inertia::render('site/detail');
    }

    //Page A Propos
    public function about(){
        return Inertia::render('site/about');
    }

    //Page de contact
    public function contact(){
        return Inertia::render('site/contact');
    }
}
