<?php

namespace App\Jobs;

use App\Models\ConsumptionPackage;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class ExpireConsumptionPackagesJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function handle(): void
    {
        ConsumptionPackage::where('status', 'active')
            ->where('expires_at', '<=', now())
            ->update([
                'status' => 'expired'
            ]);
    }
}
