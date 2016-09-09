$:.push File.expand_path("../lib", __FILE__)

require "fiscally/version"

Gem::Specification.new do |s|

  s.name        = "fiscally"
  s.version     = Fiscally::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Frank Koehl"]
  s.email       = ["frank@forgecrafted.com", "chris@forgecrafted.com"]
  s.summary     = %q{Fiscal year awareness for Ruby Date and Time classes.}
  s.description = <<-EOF
    Projects with a financial or business bent often have to deal with awareness
    of a fiscal year, which typically doesn't line up with a normal calendar
    year.

    The `Fiscally` gem adds the necessary awareness to your date and time
    objects, covering start and end dates for fiscal years and quarterly
    breakdowns.
  EOF
  s.homepage    = "https://github.com/forgecrafted/fiscally"
  s.license     = "MIT"

  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = Dir["spec/**/*"]

  s.add_development_dependency 'rb-readline', '>= 0'
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'priscilla', '>= 0'
  s.add_development_dependency 'pry-byebug', '>= 0'
  s.add_development_dependency 'fuubar', '>= 0'
  s.add_development_dependency 'coveralls', '>= 0.8.0'

  s.required_ruby_version = '>= 2.0.0'

end
