<?php

namespace App\Traits;

use Illuminate\Support\Facades\Response;

trait ResponseTrait
{


    public function success($data, $message = 'success', $code = 200)
    {
        return Response::json([
            'data' => $data,
            'message' => $message
        ], $code);
    }


    public function fail($message = 'error', $code = 400)
    {
        return Response::json([
            'data' => null,
            'success' => false,
            'message' => $message
        ], $code);
    }

}
