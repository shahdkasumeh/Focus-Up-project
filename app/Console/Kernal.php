<?php

namespace App\Console;

use App\Jobs\ActivateDueBookingsJob;
use App\Jobs\MarkNoShowBookingsJob;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

use function Illuminate\Log\log;

class Kernel extends ConsoleKernel
{
    /**
     * لتفعيل الـ Scheduler أضف هذا السطر في crontab على السيرفر:
     *   * * * * * cd /path-to-project && php artisan schedule:run >> /dev/null 2>&1
     */
    protected function schedule(Schedule $schedule): void
    {
        // كل دقيقة: تفعيل الحجوزات التي حان وقتها (pending → active)
            $schedule->job(new ActivateDueBookingsJob())
                    ->everyMinute()
                    ->withoutOverlapping()
                    ->runInBackground();

        // كل دقيقة: تحويل الحجوزات التي لم يحضر أصحابها بعد ساعة إلى no_show
            $schedule->job(new MarkNoShowBookingsJob())
                    ->everyMinute()
                    ->withoutOverlapping()
                    ->runInBackground();




    }

    protected function commands(): void
    {
        $this->load(__DIR__ . '/Commands');
        require base_path('routes/console.php');
    }
}
