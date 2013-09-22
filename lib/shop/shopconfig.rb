
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
    def get(namespace=false, key=false)
      if namespace && key
        return @config[namespace][key]
      end

      return @config if !@config.empty?

      get_config
    end

    # Set a value and save the config
    def set(key, value)
      config[key] = value
      save
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

    # Save the config in the config file
    def save
      # @todo
    end
  end
end
