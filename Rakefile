task default: %w[test]

task :test do
  system("bundle exec cucumber")
end

task :relish do
  system("bundle exec relish push victormours/chaplin")
end
