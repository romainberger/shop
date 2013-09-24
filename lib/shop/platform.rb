# coding: utf-8

# Partly stolen from https://github.com/holman/boom

module Shop
  class Platform
    # Public: tests if currently running on darwin.
    #
    # Returns true if running on darwin (MacOS X), else false
    def darwin?
      !!(RUBY_PLATFORM =~ /darwin/)
    end

    # Public: tests if currently running on windows.
    #
    # Apparently Windows RUBY_PLATFORM can be 'win32' or 'mingw32'
    #
    # Returns true if running on windows (win32/mingw32), else false
    def windows?
      !!(RUBY_PLATFORM =~ /mswin|mingw/)
    end

    # Public: returns the command used to open a file or URL
    # for the current platform.
    #
    # Currently only supports MacOS X and Linux with `xdg-open`.
    #
    # Returns a String with the bin
    def open_command
      if darwin?
        'open'
      elsif windows?
        'start'
      else
        'xdg-open'
      end
    end
  end
end
