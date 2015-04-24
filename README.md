![](https://api.travis-ci.org/victormours/chaplin.svg)

# Chaplin
## Declaratively turn JSON APIs into HTML apps

Chaplin maps HTML templates to API endpoints and renders them server-side.

## It's great for
- Quickly prototyping an app from an existing JSON API.
- Quickly shipping an non-user facing app, like an admin interface to your main app for your sales team.

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

Here is the basic structure of a Chaplin app:
```
- public/
- templates/
- app.yml
- chaplin_config.json
```

You can start the server either with the `chaplin` command, or as a Rack application.


# Documentation:

- [Reference](https://relishapp.com/victormours/chaplin/docs)

- [chaplin-blog](https://github.com/victormours/chaplin-blog) is an example app with a Parse backend

- [chaplin-init](https://github.com/victormours/chaplin-init) is a starting point with some basic front end dev tooling (gulp, zurb foundation and such)


# Support

For troubleshooting or any questions about using Chaplin, hit me up on twitter [@VictorMours](https://twitter.com/VictorMours).

