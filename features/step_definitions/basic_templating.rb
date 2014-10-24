Given(/^I have the following (.*\/)?(.*) file$/) do |directory, filename, content|
  `mkdir -p tmp/chaplin_project/#{directory}`
  `echo #{content} > tmp/chaplin_project/#{directory}/#{filename}`
end

Given(/^I have the given routes\.json file$/) do |routes_json|
  `echo #{routes_json} > tmp/chaplin_project/routes.json`
end

Given(/^I have an api running that responds to GET (.*) with the following JSON$/) do |path, json_data|
  `mkdir -p tmp/api`
  `echo #{json_data} > tmp/api/#{path}`
end

