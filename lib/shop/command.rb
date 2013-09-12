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
        return init(major)                     if command == 'init'
        return shopModule(major, minor, extra) if command == 'module'
        return override(major, minor, extra)   if command == 'override'
        return clean(major)                    if command == 'clean'
        return version                         if command == "-v"
        return version                         if command == "--version"
        return help                            if command == 'help'
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
