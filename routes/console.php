<?php
use Illuminate\Support\Facades\Schedule;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use App\Jobs\ExpireConsumptionPackagesJob;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');


//Schedule::job(new \App\Jobs\ActivateDueBookingsJob)->everyMinute();
Schedule::job(new \App\Jobs\MarkNoShowBookingsJob)->everyMinute();
Schedule::job(new ExpireConsumptionPackagesJob())->everyTenMinutes();
