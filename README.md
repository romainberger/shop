# Shop

CLI for easier Prestashop development. Actually it's just for the lazy people.

## Install

    $ gem install shop

## Usage

    $ shop override controller|class Name
    # Generates an override for a controller or a class
    # example:
    $ shop override controller Front
    # or
    $ shop override class Product


    $ shop module name
    # Generates a boilerplate for a new module
    # example:
    $ shop module dinozaure


    $ shop clean cache
    # cleans the cache and compile and stuffs

    $ shop clean class
    # clean the class index - automatically done when generating a new controller or class

    $ shop help
    # When you're lost

# Who

By [Romain Berger](http://romainberger.com).
Ping me at [@romain__berger](http://twitter.com/romain__berger) if you're having issues or create an issue.
If you become billionaire with a shop made with the help of Shop you owe me a beer.
