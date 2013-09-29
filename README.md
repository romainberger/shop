# Shop

CLI for easier [PrestaShop](http://www.prestashop.com/en/) development. Actually it's just for the lazy people.

I always use Rakefiles and Makefiles for lots of tasks. With this gem you can use these tasks without having to create any *akefiles. For more infos about how and why see: [Introducing Shop](http://romainberger.com/2013/09/29/introducing-shop/).

## Installation

    gem install shop

## Usage

### New project

Creates a new Prestashop project with:

    shop new <directory>

    # example:
    shop new
    # Download the framework in the current directory

    shop new new-store
    # Download the framework in a new directory `new-store`

Download the latest stable version of PrestaShop in the current directory or in a subdirectory if you provide the name as argument.

**Note**: Shop can work with an existing PrestaShop project, all you need is to initialize the Shop project (see [Initialization](https://github.com/romainberger/shop/#initialization) below)

### Installation

Since 1.5.4 [PrestaShop provides a CLI](http://doc.prestashop.com/display/PS15/Installing+PrestaShop+using+the+command+line) to install your PrestaShop. You can try to remember every arguments, or just use the Shop task and stay relatively sane (no offense to the PrestaShop developers but... come on).

    # php install/cli.php --name=Romain --lol=whyamitypingallthis
    # nope
    shop install

**Note**: the install task actually runs the PrestaShop PHP CLI. It just makes you happier with a nice prompt.

### Initialization

For some tasks, Shop will need to know the name of the theme you're using. To do that you need to init the project with:

    shop init <theme-name>

    # example:
    shop init my-theme

### Overrides

Creates overrides files for controllers and classes.

    shop override <controller|class> <name> [admin]

    # examples:

    # generate an override for the Product controller
    shop override controller Product

    # by default the controller will be placed in override/controllers/admin. To create an override in
    # override/controllers/admin add the `admin` argument:
    shop override controller AdminProducts admin

    # generate an override for the Product class
    shop override class Product

### New Pages

You can generate new pages for PrestaShop easily with the `controller` command. This will create the controller, template, CSS and JS files you need to create a new page.

    shop controller <page-name>

    # example:
    shop controller CustomPage

This task is adapted to work on PrestaShop 1.5 and 1.4.

### Modules

**The modules related tasks will need the Shop project to be [initialized](https://github.com/romainberger/shop)**

Creates a new module (with simple module boilerplate):

    shop module <name>

    # example:
    shop module dinozaure

Creates a module template:

    shop module template <module-name> <hook-name>

    # example:
    shop module template blockcategories blockcategories

Creates a module css file in your theme:

    shop module css <module-name>

    # example:
    shop module css blockcategories

### Cache

Cleans the css and js caches.

    shop clean [cache]
    # cleans the css and js caches

When you create a new override for a controller or a class, the class index needs to be rewritten. You can call this task

    shop clean class
    # clean the class index - automatically done when generating a new controller or class

By default the `clean` task will clean the cache so you can just use `shop clean`.

**Note**: The class index is automatically regenerated when you create an override with Shop. You probably won't need to run this command.

### Jshint

Run jshint on the theme's files.

    shop jshint

To run jshint on the theme's files and the modules' files, run it with the `modules` argument:

    shop jshint modules

To run jshint on **every** files run it with the `hard` argument (prepare yourself for a crapload of errors):

    shop jshint hard

### Makefile

Okay I kinda lied. I still use a Makefile, but only for production servers, as they rarely run gems and I don't necessarily want to install a tool for a limited use (Shop is primarily built for development purpose). But some of these tasks can be usefull on production servers. Shop can generate a Makefile file that will allow you to run some tasks.

**The Makefile task will need the Shop project to be [initialized](https://github.com/romainberger/shop)**

If you already use a Makefile, the tasks will be added to it. If you don't, it will create a Makefile.

    shop makefile

You can then use these tasks. Their effect are similar to the Shop tasks.

    make clean-cache

    make clean-class


### Help

You can get a list of the available commands with the help:

    shop help

## Configuration

You can use a configuration file to automate some values in the templates files created (modules and for the installation of PrestaShop).
You can edit this file with the command

    shop edit

It will open the config file in your `$EDITOR`. It's YAML so it shouldn't be scary.

## Compatibility

Shop has been developed and tested on osx. It may not work on platforms other than *nix, particularly the `new` command that uses the unix `unzip` command. I plan on working on rewriting this part with only Ruby so it could work everywhere. I'm not going to try it on Windows so feel free to open issues (or even better, contribute) if you notice something not working as expected.

## Who

By [Romain Berger](http://romainberger.com).
Ping me at [@romain__berger](http://twitter.com/romain__berger) if you're having issues or create an issue.

If you become billionaire with a shop made with the help of Shop you must buy me a beer.
