require 'pp'
require 'rubygems'
require 'ap'
require 'wirble'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

# Set custom prompt
IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "\n>> ",
  :PROMPT_S => "* ",
  :PROMPT_C => "? ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

# Configure awesome_print
IRB::Irb.class_eval do
  def output_value
    ap @context.last_value, :multiline => false
  end
end

# Enable printing methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Pre-filled hash and array for testing
H = { :a => 'apple', :b => 'boy', :c => 'cat', :d => 'dog', :e => 'elf' }
A = H.values

# Rails
if ENV.include?('RAILS_ENV')
  # Log SQL to STDOUT
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end
end
