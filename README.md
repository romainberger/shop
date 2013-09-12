# Shop

**Project in early development, not everything is working for now**

CLI for easier Prestashop development. Actually it's just for the lazy people.

I always use Rakefiles and Makefiles for lots of tasks. With this gem you can use this tasks without having to create the *akefiles.

## Install

    $ gem install shop

## Usage

### Initialization

For some of the task, Shop will need to know the name of the theme you're using. To do that you need to init the project with:

    $ shop init <theme-name>

### Overrides

Creates overrides files for controllers and classes.

Usage: `$ shop override controller|class Name [admin]

    $ shop override controller|class Name
    # Generates an override for a controller or a class
    # example:
    $ shop override controller Product
    # or
    $ shop override class Product

    # by default the controller will be placed in override/controllers/admin. To create an override in
    # override/controllers/admin add the `admin` argument:
    $ shop override controller AdminProducts

### Modules

Create a module or modules' templates files.

    $ shop module <name>
    # Generates a boilerplate for a new module
    # example:
    $ shop module dinozaure

    $ shop module template <module-name> <hook-name>
    # example:
    $ shop module blockcategories blockcategories

### Cache

    $ shop clean cache
    # cleans the cache and compile and stuffs

    $ shop clean class
    # clean the class index - automatically done when generating a new controller or class

### Help

You can get a list of the available commands with the help:

    $ shop help

# Who

By [Romain Berger](http://romainberger.com).
Ping me at [@romain__berger](http://twitter.com/romain__berger) if you're having issues or create an issue.
If you become billionaire with a shop made with the help of Shop you must buy me a beer.
