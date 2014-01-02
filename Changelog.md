# Shop changelog

## Head
- remove the mysql2 dependency to avoid bugs
- improve jshint task to run on mobile theme
- change `clean class-index` task to only remove the file - re-creating the file sometimes prevent the server to write it

## 0.1.9
- Change template system to use `<%= %>` instead of `{{}}`
- Creates the database in the `install` task
- Fuck yeah autocompletion

## 0.1.8
- By default the clean task clean the cache
- Add a `template` section to the configuration file so you can use custom templates
- Output the files created for every tasks
- Allow the use of the `module` task with or without file extension. ie. `shop module template name template` or `shop module template name template.tpl`
- Fix controller task and keep camelcased controllers name

## 0.1.6
- Add an `edit` command to edit the config file
- New task `controller` to create new pages
- Add some colors

## 0.1.5
- Configuration file

## 0.1.4
- First version
