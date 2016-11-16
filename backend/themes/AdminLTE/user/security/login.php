<?php
/*
 * This file is part of the Dektrium project.
 *
 * (c) Dektrium project <http://github.com/dektrium>
 *
 * For the full copyright and license information, please view the LICENSE.md
 * file that was distributed with this source code.
 */

use dektrium\user\widgets\Connect;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/**
 * @var yii\web\View                   $this
 * @var dektrium\user\models\LoginForm $model
 * @var dektrium\user\Module           $module
 */
$this->title = Yii::t('user', 'Sign in');
$this->params['breadcrumbs'][] = $this->title;
?>

<?= $this->render('/_alert', ['module' => Yii::$app->getModule('user')]) ?>



<div class="login-box">
    <div class="login-logo">
<?php echo Html::encode($this->title) ?>
    </div><!-- /.login-logo -->
    <div class="header"></div>
    <div class="login-box-body">
<?php
$form = ActiveForm::begin([
            'id' => 'login-form',
            'enableAjaxValidation' => true,
            'enableClientValidation' => false,
            'validateOnBlur' => false,
            'validateOnType' => false,
            'validateOnChange' => false,
        ])
?>
        <div class="body">
            
            <?php echo $form->field($model, 'login') ?>
            <?php echo $form->field($model, 'password')->passwordInput() ?>

        </div>
        <div class="footer">
            <div class="row">
                <div class="col-xs-8">
                    <?php echo $form->field($model, 'rememberMe')->checkbox(['class' => 'simple']) ?>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <?php
                    echo Html::submitButton('Sign In', [
                        'class' => 'btn btn-primary btn-block btn-flat',
                        'name' => 'login-button'
                    ])
                    ?>
                </div>
                <!-- /.col -->

            </div>
            <?php ActiveForm::end(); ?>
            <!--<div class="social-auth-links text-center">
                <p>- OR -</p>
                <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign in using
                    Facebook</a>
                <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i> Sign in using
                    Google+</a>
            </div>-->
                <?php if ($module->enableConfirmation): ?>
                <p >
                <?= Html::a(Yii::t('user', 'Didn\'t receive confirmation message?'), ['/user/registration/resend']) ?>
                </p>
                <?php endif ?>
                <?php if ($module->enableRegistration): ?>
                <p >
                <?= Html::a(Yii::t('user', 'Don\'t have an account? Sign up!'), ['/user/registration/register']) ?>
                </p>
            <?php endif ?>
            <?=
            Connect::widget([
                'baseAuthUrl' => ['/user/security/auth'],
            ])
            ?>
        </div>

    </div>

