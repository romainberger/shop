# coding: utf-8

module Shop
  class Command
    class << self

      # Returns the theme name
      def theme
        if init?
          return File.read('.shop')
        else
          puts "Project not initialized. Please run `shop init <theme-name>`"
          exit
        end
      end

      # Returns the path to the templates directory
      def template_path
        path = File.expand_path File.dirname(__FILE__)
        "#{path}/../../templates"
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
        return override(major, minor, extra)   if command == 'override'
        return clean(major)                    if command == 'clean'
        return jshint(major)                   if command == 'jshint'
        return makefile                        if command == 'makefile'
        return version                         if command == "-v"
        return version                         if command == "--version"
        return help                            if command == 'help'

        puts "\nCommand not found"
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

      # Runs the Prestashop install cli
      # See http://doc.prestashop.com/display/PS15/Installing+PrestaShop+using+the+command+line
      # @todo
      def install
        # prompt then run the php shit
      end

      # Init the project
      def init(name)
        if name.nil?
          puts "Error: Please specify the name of the theme"
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
        theme
        if major == 'template'
          path = "themes/#{theme}/modules"
          FileUtils.mkpath(path) unless File.directory?(path)

          path = "#{path}/#{minor}"
          FileUtils.mkpath(path) unless File.directory?(path)

          filepath = "#{path}/#{extra}.tpl"
          if File.exists?(filepath)
            puts "File already exists"
            exit
          else
            File.open(filepath, "w") do; end
          end
        elsif major == 'css'
          # css
          path = "themes/#{theme}/css/modules/#{minor}"
          FileUtils.mkpath(path) unless File.directory?(path)

          filepath = "#{path}/#{minor}.css"

          if File.exists?(filepath)
            puts "File already exists"
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
            File.open("modules/#{major}/#{major}.php", 'w') do |f|
              name = major.capitalize
              content = File.read("#{template_path}/module.php")
              content = content.gsub("{{name_capitalize}}", "#{name}")
              content = content.gsub("{{name}}", "#{major}")
              f.write(content)
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
          return puts "You need to be at the root of your Prestashop site"
        end

        File.open(path, 'w') do |f|
          f.write(content)
        end

        done
      end

      # Clean cache or class index
      # @todo
      def clean(major)
        if major == 'cache'
          # cache
          puts 'clean cache'
        elsif major == 'index'
          # index
          puts 'clean index'
        end
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
        content = File.read("#{template_path}/Makefile")
        content = content.gsub("{{theme}}", "#{theme}")
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
        puts "✔ Done"
      end

      # Returns the version of Shop
      def version
        puts "Shop #{Shop::VERSION}"
      end

      # Prints all the command available
      # @todo
      def help
        text = %{
          Shop v.#{Shop::VERSION} -------------------------------

            shop init                              Create a Shop config file
            shop module <name>                     Creates a new module
            shop module template <name> <hook>     Creates a template for a given module / hook
            shop override controller <name>        Creates an override for a controller
            shop override controller <name> admin  Cretes an override for an admin controller
            shop override class <name>             Creates an override for a class
            shop clean
            shop jshint

          See the complete documentation at:
          https://github.com/romainberger/shop

        }.gsub(/^ {10}/, '')
        puts text
      end
    end
  end
end
