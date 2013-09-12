# coding: utf-8

module Shop
  class Command
    class << self

      def execute(*args)
        command = args.shift
        major   = args.shift
        minor   = args.empty? ? nil : args.join(' ')

        dispatch(command, major, minor)
      end

      def dispatch(command, major, minor)
        # do shit
        puts 'this seems to work'
      end

      def module()
      end

      def override()
      end
    end
  end
end
