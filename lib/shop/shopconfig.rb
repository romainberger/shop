
module Shop
  class ShopConfig
    CONFIG_FILE = "#{ENV['HOME']}/.shop"

    def template
      Template.new
    end

    def initialize
      @config = {}
      bootstrap
      get
    end

    # Returns the whole config or a specific value
    #
    # namespace - the namespace where the key is searched
    # key - the key neede
    # defaultValue - default value to return if the value is nil
    def get(namespace = false, key = false, defaultValue = '')
      if namespace && key
        value = @config[namespace][key]
        if value
          return value
        else
          return defaultValue
        end
      end

      return @config if !@config.empty?

      get_config
    end

    def bootstrap
      return if File.exists?(CONFIG_FILE)
      path = template.template_path('shop')
      FileUtils.cp(path, CONFIG_FILE)
    end

    def get_config
      @config = YAML.load_file(CONFIG_FILE)
      return @config
    end

    # Public: opens the config file in an editor for you to edit. Uses the
    # $EDITOR environment variable, or %EDITOR% on Windows for editing.
    # This method is designed to handle multiple platforms.
    # If $EDITOR is nil, try to open using the open_command.
    #
    # Stolen from https://github.com/holman/boom and adapted
    #
    # Returns a String with a helpful message.
    def edit
      platform = Platform.new
      unless $EDITOR.nil?
        unless platform.windows?
          system("`echo $EDITOR` #{CONFIG_FILE} &")
        else
          system("start %EDITOR% #{CONFIG_FILE}")
        end
      else
        system("#{platform.open_command} #{CONFIG_FILE}")
      end

      "Make your edits, and do be sure to save."
    end
  end
end
