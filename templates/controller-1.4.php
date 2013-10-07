<?php

class <%= controller_name %>Core extends FrontController {

    public function setMedia() {
        parent::setMedia();

        Tools::addCSS(_THEME_CSS_DIR_.'<%= name %>.css');
        Tools::addJS(_THEME_JS_DIR_.'<%= name %>.js');
    }

    public function displayContent() {
        parent::displayContent();

        self::$smarty->display(_PS_THEME_DIR_.'<%= name %>.tpl');
    }

}
