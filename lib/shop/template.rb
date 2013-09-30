
module Shop
  class Template

    # Returns the path to the custom template if it exists
    def custom_template_path(name)
      config = ShopConfig.new
      custom_path = config.get('template', 'path')
      if File.exists?("#{custom_path}/#{name}")
        "#{custom_path}/#{name}"
      else
        false
      end
    end

    # Returns the path to the templates directory
    #
    # Returns string
    def template_path(name=false)
      custom_path = custom_template_path(name)
      if custom_path
        custom_path
      else
        path = File.expand_path File.dirname(__FILE__)

        return "#{path}/../../templates/#{name}" if name

        "#{path}/../../templates"
      end
    end

    # Replace the placeholders by the variables
    #
    # name: template name
    # datas: hash containing the values
    #
    # Returns string
    def template(name, datas)
      file = template_path(name)
      content = File.read(file)

      datas.each do |k, v|
        k = "{{#{k}}}"
        content = content.gsub(k, v)
      end
      return content
    end

  end
end
