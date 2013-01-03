module CommandBus
  private
    def execute_command(*args, &block)
      lookup_handler(args.shift).execute(*args, &block)
    end

    def lookup_handler(command_name)
      "#{command_name.to_s.camelize}CommandHandler".constantize.new
    end
end
