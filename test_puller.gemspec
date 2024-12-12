Gem::Specification.new do |s|
  s.name        = "test_puller"
  s.version     = "0.1.0"
  s.summary     = "Distribute a list of tests."
  s.description = "Distribute a list of tests until there aren't anymore."
  s.homepage    = 'https://github.com/TreyE/archi_dsl'
  s.authors     = ["Trey Evans"]
  s.email       = "lewis.r.evans@gmail.com"
  s.files       = Dir['lib/**/*.rb']
  s.license       = "MIT"

  s.add_dependency "rspec-core"
  s.add_dependency "redis"
end
