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

  # Enable FactoryGirl
  require 'factory_girl'
  require 'faker'

  class Factory
    def image_attachment
      filename = 'pixel.png'
      File.new File.join(Rails.root, 'test', 'fixtures', 'files', filename)
    end
  end

  Factory.find_definitions
end
