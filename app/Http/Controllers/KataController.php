<?php

namespace App\Http\Controllers;

use App\Http\Requests\KataRequest;
use App\Services\KataService;

class KataController extends Controller
{
    public function index()
    {
        return view('kata');
    }

    public function generateKata(KataRequest $request)
    {
        $birdName = trim($request->input('birdName'));
        $countHyphenat = substr_count($birdName, "-");
        $countSpace = substr_count($birdName, " ");
        $kata = new KataService($countHyphenat, $countSpace, $birdName);

        return back()->with('kata', "La KATA para $birdName es: ".strtoupper($kata->generateKata()));
    }
}
