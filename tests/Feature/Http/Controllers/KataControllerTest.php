<?php

namespace Tests\Feature\Http\Controllers;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class KataControllerTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    public function testGenerateKata()
    {
        $response = $this->from('/')->post('/generate_kata', [
            'birdName' => "AOAO",
        ]);

        $response->assertRedirect('/');
        // $response->assertSessionHasErrors(['errors' => 'Bird name vacio']);
        $response->assertSessionHasNoErrors();

        // $response = $this->followingRedirects()
        //     ->post('/generate_kata', ['birdName' => ''])
        //     ->assertStatus(200);
    }
}
