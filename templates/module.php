<?php

class <%= name_capitalize %> extends Module {

    public function __construct() {
        $this->name = '<%= name %>';
        $this->tab = '<%= tab %>';
        $this->version = 0.1;
        $this->author = '<%= author %>';

        parent::__construct();

        $this->displayName = $this->l('');
        $this->description = $this->l('');
    }

    public function install() {
        parent::install();
    }

}
