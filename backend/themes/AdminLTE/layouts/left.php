<?php 
use mdm\admin\components\MenuHelper;
use backend\widgets\Menu;
?>
<aside class="main-sidebar">

    <section class="sidebar">

        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="<?= Yii::$app->user->identity->profile->getAvatarUrl(230) ?>" class="img-circle" alt="User Image"/>
            </div>
            <div class="pull-left info">
                <p><?php echo Yii::$app->user->identity->profile->name ?></p>

                <a href="#"><i class="fa fa-circle text-success"></i> <?php echo Yii::t('backend','Online') ?></a>
            </div>
        </div>

        <!-- search form -->
<!--        <form action="#" method="get" class="sidebar-form">
            <div class="input-group fa-arrows-h">
                <input type="text" name="q" class="form-control" placeholder="Search..."/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
            </div>
        </form>-->
        <!-- /.search form -->

        <?php         
        $callback = function($menu){
						$data = eval($menu['data']);
						return [
							'label' => $menu['name'], 
							'url' => [$menu['route']],
							'options' =>['class' => 'sub-menu'],
							'items' => $menu['children'],
                                                        'icon'  => $menu['icon']
						];
						};
        echo dmstr\widgets\Menu::widget(
            [
                'options' => ['class' => 'sidebar-menu'],
                'items' => MenuHelper::getAssignedMenu(Yii::$app->user->id, null, $callback)
            ]
        ) ?>

    </section>

</aside>
