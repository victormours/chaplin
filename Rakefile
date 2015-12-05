task default: %w[test]

task :test do
  system("bundle exec cucumber")
end

task :relish do
  system("bundle exec relish push victormours/chaplin")
end

task :publish do
  `gem build chaplin.gemspec`
  `gem push chaplin-*.gem`
  `rm chaplin-*.gem`
end
