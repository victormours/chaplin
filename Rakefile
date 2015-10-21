task default: %w[test]

task :test do
  system("bundle exec cucumber")
end

task :relish do
  system("bundle exec relish push victormours/chaplin")
end

task :build do
  `gem build chaplin.gemspec`
end

task :publish do
  `gem push chaplin-*.gem`
end
