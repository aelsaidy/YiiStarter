<?php
namespace common\components;
use yii\base\BootstrapInterface;
use yii;
class LanguageSelector implements BootstrapInterface
{
    public $supportedLanguages = [];

    public function bootstrap($app)
    {
        $language ;
        if(!empty(\Yii::$app->session))
        {
          if(empty(Yii::$app->user->identity->profile))
          $language =   'en'; 
          else
          $language =   Yii::$app->user->identity->profile->language ;    
        }
        else
          $language = 'en';  
        
        if(empty($language))
        $preferredLanguage = $app->request->getPreferredLanguage($this->supportedLanguages);
        else
        $preferredLanguage =     $language ;
        $app->language = $preferredLanguage;
    }
}
