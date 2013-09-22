
module Shop
  class Template

    # Returns the path to the templates directory
    #
    # Returns string
    def template_path(name=false)
      path = File.expand_path File.dirname(__FILE__)

      return "#{path}/../../templates/#{name}" if name

      "#{path}/../../templates"
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
