<?php

class {{controller_name}}Core extends FrontController {

    public function setMedia() {
        parent::setMedia();

        $this->addCSS(_THEME_CSS_DIR_.'{{name}}.css');
        $this->addJS(_THEME_JS_DIR_.'{{name}}.js');
    }

    /**
     * Assign template vars related to page content
     * @see FrontController::initContent()
     */
    public function initContent() {
        parent::initContent();

        $this->setTemplate(_PS_THEME_DIR_.'{{name}}.tpl');
    }

}
