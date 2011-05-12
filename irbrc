IRB.conf[:AUTO_INDENT] = true

# Pre-filled hash and array for testing
H = { :a => 'apple', :b => 'boy', :c => 'cat', :d => 'dog', :e => 'elf' }
A = H.values

# Rails
if ENV.include?('RAILS_ENV')
  require 'factory_girl'
  require 'faker'
  require 'logger'

  # Log SQL to STDOUT
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end

  # Enable FactoryGirl
  class Factory
    def image_attachment
      filename = 'pixel.png'
      File.new File.join(Rails.root, 'test', 'fixtures', 'files', filename)
    end
  end

  Factory.find_definitions

  def add_package(division = nil)
    d = division || Division.first || Factory(:division)
    p = Factory(:package, :division => d)

    (1..3).each do |n|
      Factory :deal, :level => n, :package => p
    end
  end
end
