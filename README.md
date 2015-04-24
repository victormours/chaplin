![](https://api.travis-ci.org/victormours/chaplin.svg)

# Chaplin
## Declaratively turn JSON APIs into HTML apps

Chaplin maps HTML templates to API endpoints and renders them server-side.

It's great for:
  - Quickly prototyping an app from an existing JSON API.
  - Quickly shipping an non-user facing app, like an admin interface to your main app for your sales team.
  - Writing an app only using HTML, Mustache and YAML.


# Installing

Like any other Ruby gem, Chaplin can be installed with
```
$ gem install chaplin
```
Or added to an existing project's Gemfile
```
  gem 'chaplin'
```

# Getting started:

You can create a new project with
```
$ chaplin new my-app
```

Here is the basic structure of a Chaplin app:
```
- public/             # all files in there are served statically
- templates/          # HTML templates that will be rendered using Mustache
- app.yml             # The YAML mapping between API endpoints and HTML templates
- chaplin_config.yml  # The url of the API the server will connect to, and other configuration values
```


You can start the server either with the `chaplin` command, or as a Rack application.


# Documentation:

- [Reference](https://relishapp.com/victormours/chaplin/docs)

- [chaplin-blog](https://github.com/victormours/chaplin-blog) is an example app with a Parse backend

- [chaplin-init](https://github.com/victormours/chaplin-init) is a starting point with some basic front end dev tooling (gulp, zurb foundation and such)

# Support

For troubleshooting or any questions about using Chaplin, hit me up on twitter [@VictorMours](https://twitter.com/VictorMours).

