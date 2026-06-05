<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Validation\ValidationException;

class NewPasswordController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'email' => ['required', 'email'],
            'otp' => ['required', 'string', 'size:6'],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        // Check OTP from cache
        $cachedOtp = Cache::get('reset_otp_' . $request->email);

        if (!$cachedOtp) {
            throw ValidationException::withMessages([
                'otp' => ['OTP expired. Please request a new one.'],
            ]);
        }

        if ($cachedOtp != $request->otp) {
            throw ValidationException::withMessages([
                'otp' => ['Invalid OTP code.'],
            ]);
        }

        // Update password
        $user = User::where('email', $request->email)->first();

        if (!$user) {
            throw ValidationException::withMessages([
                'email' => ['User not found.'],
            ]);
        }

        $user->password = Hash::make($request->password);
        $user->save();

        // Delete OTP from cache
        Cache::forget('reset_otp_' . $request->email);

        // Delete all tokens to force re-login
        $user->tokens()->delete();

        return response()->json([
            'message' => 'Password reset successfully',
            'status' => 'success'
        ]);
    }
}
