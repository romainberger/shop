# coding: utf-8

module Shop
  class Command
    class << self
      include Shop::Color

      def template
        Template.new
      end

      # Returns the theme name
      def theme
        if init?
          return File.read('.shop')
        else
          puts "#{red("Error")}: Project not initialized."
          puts "Please run #{cyan("shop init <theme-name>")}"
          exit
        end
      end

      def execute(*args)
        command = args.shift
        major   = args.shift
        minor   = args.shift
        extra   = args.shift

        return help unless command
        dispatch(command, major, minor, extra)
      end

      def dispatch(command, major, minor, extra)
        return newProject(major)               if command == 'new'
        return init(major)                     if command == 'init'
        return install                         if command == 'install'
        return shopModule(major, minor, extra) if command == 'module'
        return override(major)                 if command == 'override'
        return controller(major, minor)        if command == 'controller'
        return clean(major)                    if command == 'clean'
        return jshint(major)                   if command == 'jshint'
        return makefile                        if command == 'makefile'
        return edit                            if command == 'edit'
        return version                         if command == "-v"
        return version                         if command == "--version"
        return help                            if command == 'help'

        puts "\n#{red("Error")}: Command not found"
        return help
      end

      # Download the framework in the current dir
      # or a creates a dir if an argument is given
      def newProject(path)
        unless path.nil?
          FileUtils.mkpath(path)
        else
          path = "./"
        end

        puts "Please wait..."
        print "Downloading the framework... "
        url = 'https://github.com/PrestaShop/PrestaShop/archive/master.zip'
        open("master.zip", "wb") do |f|
          f << open(url).read
        end
        done

        # @todo unzip with a ruby way to avoid platform incompatibilities
        print "Unzip... "
        system "unzip -q master.zip"
        done

        print "Copying... "
        FileUtils.cp_r(Dir["PrestaShop-master/*"], path)
        done

        print "Cleaning... "
        # remove useless files
        File.delete("master.zip")
        FileUtils.rm_rf("PrestaShop-master")

        done
      end

      # Runs the Prestashop install CLI but with a nice prompt
      #
      # See http://doc.prestashop.com/display/PS15/Installing+PrestaShop+using+the+command+line
      def install
        # check if the framework is already installed
        if File.exists?('config/settings.inc.php')
          puts "PrestaShop appears to be already installed"
          exit
        end

        puts "Please answer the following: "

        # Default values
        config = ShopConfig.new
        db_server = config.get('install', 'db_server', 'localhost')
        db_user = config.get('install', 'db_user', 'root')
        db_password = config.get('install', 'db_password')
        country = config.get('install', 'country', 'fr')
        firstname = config.get('install', 'firstname', false)
        lastname = config.get('install', 'lastname', false)
        password = config.get('install', 'password', '0123456789')
        email = config.get('install', 'email', false)

        entry = Hash.new

        entry[:domain]      = ask('Domain: ')
        entry[:db_name]     = ask('Database name: ')
        entry[:db_server]   = ask('Database server: ') { |q| q.default = db_server }
        entry[:db_user]     = ask('Database user: ') { |q| q.default = db_user }
        entry[:db_password] = ask('Database password: ') { |q| q.default = db_password }
        entry[:country]     = ask('Country: ') { |q| q.default = country }
        entry[:firstname]   = ask('Firstname: ') { |q| q.default = firstname if firstname }
        entry[:lastname]    = ask('Lastname: ') { |q| q.default = lastname if lastname }
        entry[:password]    = ask('Password: ') { |q| q.default = password }
        entry[:email]       = ask('Email: ') { |q| q.default = email if email }

        command = "php install-dev/index_cli.php "
        command << "--domain=#{entry[:domain]} "
        command << "--db_name=#{entry[:db_name]} "
        command << "--db_server=#{entry[:db_server]} "
        command << "--db_user=#{entry[:db_user]} "
        command << "--db_password=#{entry[:db_password]} "
        command << "--country=#{entry[:country]} "
        command << "--firstname=#{entry[:firstname]} "
        command << "--lastname=#{entry[:lastname]} "
        command << "--password=#{entry[:password]} "
        command << "--email=#{entry[:email]} "
        command << "--newsletter=0"

        # run the php script
        puts "Installing Prestashop please wait... "
        system command
        done
      end

      # Init the project
      def init(name)
        if name.nil?
          puts "#{red("Error:")} Please specify the name of the theme"
          return puts "    $ shop init <theme-name>"
        end

        File.open('.shop', 'w') do |f|
          f.write(name)
        end

        done
      end

      # Check if the Shop project has been initialized
      #
      # Returns a boolean
      def init?
        File.exists?('.shop')
      end

      # Creates a module or a module template
      # prefixed with shop for obvious reasons
      #
      # The project needs to be initialized
      def shopModule(major, minor, extra)
        if major == 'template'
          theme
          path = "themes/#{theme}/modules"
          FileUtils.mkpath(path) unless File.directory?(path)

          path = "#{path}/#{minor}"
          FileUtils.mkpath(path) unless File.directory?(path)

          filepath = "#{path}/#{extra}.tpl"
          if File.exists?(filepath)
            puts "#{red("Error:")} File already exists"
            exit
          else
            File.open(filepath, "w") do; end
          end
        elsif major == 'css'
          theme
          # css
          path = "themes/#{theme}/css/modules/#{minor}"
          FileUtils.mkpath(path) unless File.directory?(path)

          filepath = "#{path}/#{minor}.css"

          if File.exists?(filepath)
            puts "#{red("Error:")} File already exists"
            exit
          elsif
            File.open(filepath, "w") do; end
          end
        else
          # create a module
          if File.directory?("modules/#{major}")
            return puts "Module #{major} already exists"
          else
            FileUtils.mkpath("modules/#{major}")
            config = ShopConfig.new
            values = {
              "name_capitalize" => major.capitalize,
              "name" => major,
              "author" => config.get('module', 'author'),
              "tab" => config.get('module', 'tab')
            }
            content = template.template("module.php", values)
            File.open("modules/#{major}/#{major}.php", 'w') do |f|
              f.write(content)
            end

            # copy the logos
            logo = config.get('module', 'logo')
            if logo.length != 0
              if File.exists?("#{logo}.png")
                FileUtils.cp("#{logo}.png", "modules/#{major}/logo.png")
              end
              if File.exists?("#{logo}.gif")
                FileUtils.cp("#{logo}.gif", "modules/#{major}/logo.gif")
              end
            end
          end
        end

        done
      end

      # Creates an override for controllers and classes
      def override(major, minor, extra)
        name = minor.capitalize
        if major == 'controller'
          # controller
          if !extra.nil? && extra == 'admin'
            side = 'admin'
          else
            side = 'front'
          end

          name = "#{name}Controller"
          filename = "#{name}.php"
          path = "override/controllers/#{side}/#{filename}"


        elsif major == 'class'
          # class
          filename = "#{name}.php"
          path = "override/classes/#{filename}"
        end

        content = "<?php\n\nclass #{name} extends #{name}Core {\n\n}\n"

        if !File.directory?('override')
          return puts "#{red("Error:")} You need to be at the root of your Prestashop site"
        end

        File.open(path, 'w') do |f|
          f.write(content)
        end

        clean("class")

        done
      end

      # Creates a new page with controller and files associated
      #
      # @todo adapt this to work with PS 1.4 (needs a .php file in the root dir)
      def controller(major)
        if major.nil?
          puts "#{red("Error")}: Please provide a name for the page"
          exit
        end
        theme

        name = major.downcase
        controller_name = "#{name.capitalize}Controller"
        filename = "#{controller_name}Controller.php"
        controller_path = "controllers/front/#{filename}"

        if File.exists?(controller_path)
          puts "#{red("Error")}: Controller already exists"
          exit
        end

        datas = {
          'controller_name' => controller_name,
          'name' => name.downcase
        }

        content = template.template("controller.php", datas)
        File.open(controller_path, "w") do |f|
          f.write(content)
        end

        files = [
          "themes/#{theme}/#{name}.tpl",
          "themes/#{theme}/css/#{name}.css",
          "themes/#{theme}/js/#{name}.js"
        ]

        files.each do |f|
          File.open(f, "w") do; end
        end

        clean("class")

        done
      end

      # Clean cache or class index
      def clean(major)
        if major == 'cache'
          theme
          files = Dir["themes/#{theme}/cache/*.css"]
          files = files + Dir["themes/#{theme}/cache/*.js"]

          files.each do |f|
            File.delete(f)
          end
        elsif major == 'class'
          print "Cleaning class index... "
          index = "cache/class_index.php"
          if File.exists?(index)
            File.delete(index)
          end
          File.open(index, "w") do; end
          # the file needs to be chmod'ed to 666
          File.chmod(0666, index)
        end

        done
      end


      # Run jshint
      def jshint(major)
        theme
        files = Dir["themes/#{theme}/js/**/*.js"]

        if major == 'modules' || major == 'hard'
          modules = Dir["modules/**/*.js"]
          files = files + modules
        end
        if major == 'hard'
          prestashop = Dir["js/**/*.js"]
          files = files + prestashop
        end

        files.each do |f|
          system "jshint #{f}"
        end
      end

      # Create a Makefile or add some tasks to an existing one
      def makefile
        theme
        datas = { 'theme' => theme}
        content = template.template('Makefile', datas)
        if File.exists?("Makefile")
          File.open("Makefile", "a") do |f|
            f.write(content)
          end
        else
          File.open("Makefile", "w") do |f|
            f.write(content)
          end
        end

        done
      end

      def done
        puts "#{green("✔ Done")}"
      end

      def edit
        config = ShopConfig.new
        puts config.edit
      end

      # Returns the version of Shop
      def version
        puts "Shop #{Shop::VERSION}"
      end

      # Prints all the command available
      def help
        text = %{
          Shop v.#{Shop::VERSION} -------------------------------

            shop new <directory>                   Download the framework
            shop install                           Install Prestashop

            shop init                              Creates a Shop config file

            shop module <name>                     Creates a new module
            shop module template <name> <hook>     Creates a template for a given module / hook
            shop module css <name>                 Creates an override for a module css

            shop override controller <name>        Creates an override for a controller
            shop override controller <name> admin  Creates an override for an admin controller
            shop override class <name>             Creates an override for a class

            shop clean cache                       Cleans the css and js caches
            shop clean class                       Cleans the class index

            shop jshint                            Run jshint on the theme files
            shop jshint modules                    Run jshint on the theme and modules files
            shop jshint hard                       Run jshint on every files

            shop makefile                          Creates a Makefile or add tasks to an existing one

          See the complete documentation at:
          https://github.com/romainberger/shop

        }.gsub(/^ {10}/, '')
        puts text
      end
    end
  end
end
