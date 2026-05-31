<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\ValidationException;

class PasswordResetLinkController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'email' => ['required', 'email'],
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            throw ValidationException::withMessages([
                'email' => ['User not found.'],
            ]);
        }

        // Generate OTP
        $otp = rand(100000, 999999);

        // Store OTP in cache
        Cache::put('reset_otp_' . $request->email, $otp, now()->addMinutes(10));

        Mail::raw("Your OTP code is: $otp\n\nThis code will expire in 10 minutes.\n\nIf you didn't request this, please ignore this email.", function ($message) use ($request) {
            $message->to($request->email)
                ->subject('Your Password Reset OTP');
        });

        return response()->json([
            'message' => 'Password reset OTP sent successfully to your email',
            'expires_in' => 10
        ]);
    }
}
