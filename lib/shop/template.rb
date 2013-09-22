
module Shop
  class Template

    # Returns the path to the templates directory
    #
    # Returns string
    def template_path(name)
      path = File.expand_path File.dirname(__FILE__)
      if name.nil?
        "#{path}/../../templates"
      else
        "#{path}/../../templates/#{name}"
      end
    end

    # Replace the placeholders by the variables
    #
    # name: template name
    # datas: hash containing the values
    #
    # Returns string
    def template(name, datas)
      file = "#{template_path}/#{name}"
      content = File.read(file)

      datas.each do |k, v|
        k = "{{#{k}}}"
        content = content.gsub(k, v)
      end
      return content
    end

  end
end
