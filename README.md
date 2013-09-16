# Shop

**Project in early development, not everything is working for now**

CLI for easier [PrestaShop](http://www.prestashop.com/en/) development. Actually it's just for the lazy people.

I always use Rakefiles and Makefiles for lots of tasks. With this gem I can use these tasks without having to create the *akefiles.

## Installation

    $ gem install shop

Shop has been developed on OSX and tested on OSX. I have no idea if this works on other platforms.

## Usage

### New project

Creates a new Prestashop project with:

    $ shop new <directory>

    # example:
    $ shop new
    # Download the framework in the current directory

    $ shop new new-store
    # Download the framework in a new directory `new-store`

Download the latest stable version of PrestaShop in the current directory or in a subdirectory if you provide the name as argument.

**Note**: Shop can work with an existing PrestaShop project, all you need is to initialize the Shop project (see [Initialization](https://github.com/romainberger/shop/#initialization) below)

### Installation

Since 1.5.4 [PrestaShop provides a CLI](http://doc.prestashop.com/display/PS15/Installing+PrestaShop+using+the+command+line) to install your PrestaShop. You can try to remember every arguments, or just use the Shop task and stay relatively sane (no offense to the PrestaShop developers but... come on).

    # $ php install/cli.php --name=Romain --lol=whyamitypingallthis
    # nope
    $ shop install

**Note**: the install task actually runs the PrestaShop PHP CLI. It just makes you happier with a nice prompt.

### Initialization

For some tasks, Shop will need to know the name of the theme you're using. To do that you need to init the project with:

    $ shop init <theme-name>

    # example:
    $ shop init my-theme

### Overrides

Creates overrides files for controllers and classes.

    $ shop override <controller|class> <name> [admin]

    # examples:

    # generate an override for the Product controller
    $ shop override controller Product

    # by default the controller will be placed in override/controllers/admin. To create an override in
    # override/controllers/admin add the `admin` argument:
    $ shop override controller AdminProducts admin

    # generate an override for the Product class
    $ shop override class Product

### Modules

**The modules related tasks will need the Shop project to be [initialized](https://github.com/romainberger/shop)**

Creates a new module (with simple module boilerplate):

    $ shop module <name>

    # example:
    $ shop module dinozaure

Creates a module template:

    $ shop module template <module-name> <hook-name>

    # example:
    $ shop module blockcategories blockcategories

Creates a module css file in your theme:

    $ shop module css <module-name>

    # example:
    $ shop module css blockcategories

### Cache

Cleans the css, js and smarty caches.

    $ shop clean cache
    # cleans the cache and compile and stuffs

When you create a new override for a controller or a class, the class index needs to be rewritten. You can call this task ()

    $ shop clean class
    # clean the class index - automatically done when generating a new controller or class

**Note**: The class index is automatically regenerated when you create an override with Shop. You probably won't need to run this command.

### Makefile

Okay I kinda lied. I still use a Makefile, but only for production servers, as they rarely run gems and I don't necessarily want to install a tool for a limited use (Shop is primarily built for development purpose). But some of these tasks can be usefull on production servers. Shop can generate a Makefile file that will allow you to run some tasks:

    $ shop makefile

You can then use these tasks. Their effect are similar to the Shop tasks.

    $ make clean-cache

    $ make clean-class


### Help

You can get a list of the available commands with the help:

    $ shop help

# Who

By [Romain Berger](http://romainberger.com).
Ping me at [@romain__berger](http://twitter.com/romain__berger) if you're having issues or create an issue.
If you become billionaire with a shop made with the help of Shop you must buy me a beer.
