<?php

return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
    'name' => 'Multi Channel',
    'bootstrap' => [
        [
            'class' => 'common\components\LanguageSelector',
            'supportedLanguages' => ['en','nl'],
        ],
    ],
    'modules' => [
        'user' => [
            'class' => 'dektrium\user\Module',
            'enableConfirmation' => false,
            'admins' => ['admin'],
            'modelMap' => [
                'Profile' => 'common\models\Profile',
            ],
            'controllerMap' => [
            //'admin' => 'common\controllers\AdminController',
            ],
        ],
        'admin' => [
            'class' => 'mdm\admin\Module',
        ]
    ],
    'components' => [
        /* 'cache' => [
          'class' => 'yii\caching\FileCache',
          ], */
        /*'user' => [
            'identityClass' => 'dektrium\user\models\User',
            'loginUrl' => ['user/security/login'],
        ],*/
        'authManager' => [
            'class' => 'yii\rbac\DbManager'
        ],
        'schedule' => 'omnilight\scheduling\Schedule',
        'i18n' => [
        'translations' => [
//            'frontend*' => [
//                'class' => 'yii\i18n\PhpMessageSource',
//                'basePath' => '@common/messages',
//            ],
            'backend*' => [
                'class' => 'yii\i18n\PhpMessageSource',
                'basePath' => '@common/messages',
            ],
        ],
        ],
    ],
    /*'as access' => [
        'class' => 'mdm\admin\components\AccessControl',
        'allowActions' => [
            'admin/*',
            'gii/*',
            'debug/*',
            'site/*',
            'user/*',
        ]
    ],*/
];
