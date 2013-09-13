# Shop

**Project in early development, not everything is working for now**

CLI for easier Prestashop development. Actually it's just for the lazy people.

I always use Rakefiles and Makefiles for lots of tasks. With this gem you can use these tasks without having to create any *akefiles.

## Installation

    $ gem install shop

## Usage

### Initialization

For some of the task, Shop will need to know the name of the theme you're using. To do that you need to init the project with:

    $ shop init <theme-name>

### Overrides

Creates overrides files for controllers and classes.

    $ shop override <controller|class> <name> [admin]

Examples:

    # generate a controller
    $ shop override controller Product

    # by default the controller will be placed in override/controllers/admin. To create an override in
    # override/controllers/admin add the `admin` argument:
    $ shop override controller AdminProducts admin

    # generate a class
    $ shop override class Product

### Modules

Create a module or modules' templates files.

Create a module (with simple module boilerplate):

    $ shop module <name>

    # example:
    $ shop module dinozaure

Create a module template:

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
