<?php
namespace common\widgets;

use yii\base\BootstrapInterface;
use yii\base\Application;

class Bootschedule implements BootstrapInterface
{
    public function bootstrap(Application $app)
    {
        if ($app instanceof \yii\console\Application) {
            if ($app->has('schedule')) {
                /** @var omnilight\scheduling\Schedule $schedule */
                $schedule = $app->get('schedule');
                // Place all your shedule command below
                $schedule->command('my-extension-command')->dailyAt('12:00');
            }
        }
    }
}