Given(/^I set the environment variable (\S+) to (\d+)$/) do |variable_name, value|
  ENV[variable_name] = value
end
