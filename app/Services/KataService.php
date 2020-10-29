<?php

namespace App\Services;

class KataService
{

    private $countHyphenat = 0;
    private $countSpace = 0;
    private $count = 0;
    private $birdName = '';

    public function __construct(int $countHyphenat, int $countSpace, string $birdName)
    {
        $this->countHyphenat = $countHyphenat;
        $this->countSpace = $countSpace;
        $this->count = $countHyphenat + $countSpace;
        $this->birdName = $birdName;
    }

    public function generateKata()
    {
        if ($this->count == 0) {
            $kata = $this->onePhrase();
        } else {
            if ($this->count == 1) {
                $kata = $this->twoPhrases();
            } else {
                if ($this->count == 2) {
                    $kata = $this->threePhrases();
                } else {
                    $kata = $this->fourPhrases();
                }
            }
        }
        return $kata;
    }

    private function onePhrase()
    {
        $kata = substr($this->birdName, 0, 4);
        return $kata;
    }

    private function twoPhrases()
    {
        $kata = '';
        $twoPhrasesArrays = str_word_count($this->birdName, 1);
        foreach ($twoPhrasesArrays as $phrase) {
            $kata .= substr($phrase, 0, 2);
        }
        return $kata;
    }

    private function threePhrases()
    {
        $kata = '';
        $threePhrasesArrays = str_word_count($this->birdName, 1);
        foreach ($threePhrasesArrays as $phrase) {
            if (substr_count($phrase, "-") == 0) {
                if ($phrase !== end($threePhrasesArrays) && $this->countSpace == $this->count) {
                    $kata .= substr($phrase, 0, 1);
                } else {
                    $kata .= substr($phrase, 0, 2);
                }
            } else {
                $twoPhrases = str_replace("-", " ", $phrase);
                $twoPhrasesArrays = str_word_count($twoPhrases, 1);
                foreach ($twoPhrasesArrays as $phrase) {
                    if ($phrase === end($twoPhrasesArrays) && $this->countHyphenat == $this->count) {
                        $kata .= substr($phrase, 0, 2);
                    } else {
                        $kata .= substr($phrase, 0, 1);
                    }
                }
            }
        }
        return $kata;
    }

    private function fourPhrases()
    {
        $kata = '';
        $fourPhrases = str_replace("-", " ", $this->birdName);
        $fourPhrasesArrays = str_word_count($fourPhrases, 1);
        foreach ($fourPhrasesArrays as $phrase) {
            $kata .= substr($phrase, 0, 1);
        }
        return $kata;
    }
}
