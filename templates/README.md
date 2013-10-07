# Shop templates files

## How to override the basic templates

You can use your own templates if you don't like those included in Shop. To do that you need to specify where your templates are, then write them.

### Configuration

To tell Shop where to find your templates, you need to edit the config file. To do so, run `$ shop edit` to open the config file in your `$EDITOR` (or just open `~/.shop`):

    template:
        path: ~/path/to/your/templates

### Write your templates

You can override every templates by creating a file in your template directory with the exact same name as the built-in template. Note that you don't have to re-create every templates: if Shop doesn't find your template it will take the basic template. Inside of your template you will need the variables provided to create some content. The easiest way to create your templates is to use the existing templates and modify them.

### Existing templates

Here is an exhaustive list of the templates and their use:

| Filename           | Use       |
|--------------------|-----------|
|controller.php      |Basic controller boilerplate for PrestaShop 1.5|
|controller-1.4.php  |Basic controller boilerplate for PrestaShop 1.4|
|Makefile            |Makefile containing some cache related tasks|
|module.php          |Basic module boilerplate|
|page.php            |Page boilerplate, only used for PrestaShop 1.4 - you probably won't need to customize this one|
