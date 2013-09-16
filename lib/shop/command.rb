# coding: utf-8

module Shop
  class Command
    class << self

      def execute(*args)
        command = args.shift
        major   = args.shift
        minor   = args.shift
        extra   = args.empty? ? nil : args.join(' ')

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
        return makefile                        if command == 'makefile'
        return version                         if command == "-v"
        return version                         if command == "--version"
        return help                            if command == 'help'
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
      def install
        # prompt then run the php shit
      end

      # Init the project
      def init(name)
        if name.nil?
          return puts "Error: Please specify the name of the theme"
        end

        File.open('.shop', 'w') do |f|
          f.write(name)
        end

        done
      end

      # Creates a module or a module template
      # prefixed with shop for obvious reasons
      def shopModule(major, minor, extra)
        if major == 'template'
          # template
          puts 'create module template'
        else
          # create a module
          if File.directory?("modules/#{major}")
            return puts "Module #{major} already exists"
          else
            FileUtils.mkpath("modules/#{major}")
            File.open("modules/#{major}/#{major}.php", 'w') do |f|
              name = major.capitalize
              content = "<?php\n\nclass #{name} extends Module {\n\n}\n"
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
      def clean(major)
        if major == 'cache'
          # cache
          puts 'clean cache'
        elsif major == 'index'
          # index
          puts 'clean index'
        end
      end

      def makefile
        if File.exists?("Makefile")
          puts "Add to existing Makefile"
        else
          puts "Create makefile"
        end
      end

      def done
        puts "✔ Done"
      end

      def version
        puts "Shop #{Shop::VERSION}"
      end

      def help
        puts "Output help"
      end
    end
  end
end
