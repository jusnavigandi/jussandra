Gem::Specification.new do |s|
  s.name    = 'jussandra'
  s.version = '0.5.0.pre'
  s.email   = "tecnologia@jus.com.br"
  s.author  = "Jus Navigandi"

  s.description = %q{Gives you most of the familiarity of ActiveRecord, but with the scalability of cassandra. Project based on original fork: http://github.com/NZKoz/cassandra_object}
  s.summary     = %q{Maps your objects into cassandra.}
  s.homepage    = %q{http://github.com/jusnavigandi/jussandra}

  s.add_dependency('activesupport', '>= 3.0.pre')
  s.add_dependency('activemodel',   '>= 3.0.pre')
  s.add_dependency('cassandra',     '>= 0.7.2')

  s.files = Dir['lib/**/*'] + Dir["vendor/**/*"]
  s.require_path = 'lib'
end