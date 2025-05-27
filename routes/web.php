<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/pindahHalaman', function () {
    return view('pindahHalaman');
});

Route::get('/profil', function () {
    return view('profil');
});