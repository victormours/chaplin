Gem::Specification.new do |gem|
  gem.name        = 'chaplin'
  gem.version     = '0.0.0'
  gem.licenses    = ['MIT']
  gem.summary     = "Build HTML apps from JSON APIs in no time"
  gem.description = "Chaplin maps JSON APIs to Mustache templates to quickly create HTML apps, without writing glue code."
  gem.authors     = ["Victor Mours"]
  gem.email       = 'victor.mours@gmail.com'
  gem.files       = Dir["lib/**/*.rb"]
  gem.executables = ['chaplin']

  gem.add_runtime_dependency "rack"
  gem.add_runtime_dependency "sinatra"
  gem.add_runtime_dependency "sinatra-contrib"
  gem.add_runtime_dependency "faraday"
  gem.add_runtime_dependency "mustache"

  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-preloader"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "relish"
  gem.add_development_dependency "childprocess"
end
