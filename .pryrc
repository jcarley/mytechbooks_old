begin
  require 'awesome_print' 
  Pry.config.print = proc { |output, value| output.puts value.ai }
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
rescue LoadError => err
  puts "no awesome_print :("
end
