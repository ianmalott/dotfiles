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

  if 'levelup' == ENV['PROJECT']
    def ian
      email = 'ian@thelevelup.com'

      @ian ||= User.find_by_email(email) || User.create(
        :first_name                => 'Ian',
        :last_name                 => 'Malott',
        :email                     => email,
        :division_id               => 1,
        :new_password              => 'foo',
        :new_password_confirmation => 'foo',
        :born_at                   => Date.parse('02/12/1987'),
        :gender                    => 'male'
      )
    end
  end
end
