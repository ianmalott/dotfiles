IRB.conf[:AUTO_INDENT] = true

# Pre-filled hash and array for testing
H = { :a => 'apple', :b => 'boy', :c => 'cat', :d => 'dog', :e => 'elf' }
A = H.values

# Rails
if ENV.include?('RAILS_ENV')
  require 'logger'

  # Log SQL to STDOUT
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end
end
