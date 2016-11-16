<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/../../common/config/params-local.php'),
    require(__DIR__ . '/params.php'),
    require(__DIR__ . '/params-local.php')
);

return [
    'id' => 'app-backend',
    'basePath' => dirname(__DIR__),
    'controllerNamespace' => 'backend\controllers',
    'bootstrap' => ['log'],
    'modules' => [
        'settings' => [
        'class' => 'pheme\settings\Module',
        'sourceLanguage' => 'en'
        ],
    ],
    'components' => [
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],       
        'view' => [
             'theme' => [
                 'pathMap' => [
                    '@app/views' => '@themes/AdminLTE',
                    '@dektrium/user/views' => '@themes/AdminLTE/user'
                 ],
             ],
        ],
        'settings' => [
        'class' => 'pheme\settings\components\Settings'
        ],
        /*
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
            ],
        ],
        */
        'user' => [
            'identityClass' => 'dektrium\user\models\User',
            'loginUrl' => ['user/security/login'],
        ],
    ],
    'as access' => [
        'class' => 'mdm\admin\components\AccessControl',
        'allowActions' => [
            'admin/*',
            'gii/*',
            'debug/*',
            'site/*',
            'user/*',
        ]
    ],
    'params' => $params,
];
