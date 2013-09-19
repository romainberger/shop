
module Shop
  class Config
    CONFIG_FILE = "#{ENV['HOME']}/.shop"

    def get(key)

    end

    def set(key)

    end

    def bootstrap
      return if File.exists(CONFIG_FILE)
      FileUtils.cp()
    end

    def save
    end
  end
end
