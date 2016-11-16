Yii 2 Advanced Project Template
===============================

1. Run 
```
#!code

composer update
```

1. Run init.bat.
1. Change DB settings from /common/config/main-local.php file
1. Do the migration

```
#!code

yii migrate/up --migrationPath=@vendor/dektrium/yii2-user/migrations
yii migrate --migrationPath=@mdm/admin/migrations
yii migrate --migrationPath=@yii/rbac/migrations
```
Must add field Icon on table menu



Extention-scheduling(corn job): How to use this extension in your application?
------------------------------------------------------------------------------

Next your should add the following command to your crontab:
```
* * * * * php /path/to/yii yii schedule/run --scheduleFile=@console/config/schedule.php 1>> /dev/null 2>&1
```
https://github.com/omnilight/yii2-scheduling
```

Extention-HTTP Client : How to use this extension in your application?
----------------------------------------------------------------------
use yii\httpclient\Client;
$client = new Client(['baseUrl' => 'http://domain.com/api/1.0']);
```
use yii\httpclient\Client;
$client = new Client(['baseUrl' => 'http://domain.com/api/1.0']);
$response = $client->createRequest()
    ->setFormat(Client::FORMAT_JSON)
    ->setUrl('articles/search')
    ->setData([
        'query_string' => 'Yii',
        'filter' => [
            'date' => ['>' => '2015-08-01']
        ],
    ])
    ->send();
```
https://github.com/yiisoft/yii2-httpclient/blob/master/docs/guide/README.md
