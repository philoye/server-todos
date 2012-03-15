## What is this?

The ubiquitous [LocalTodos](http://documentcloud.github.com/backbone/examples/todos/index.html) backbone example code is great, but I wondered about:

*  Hooking it up to a REST API
*  Generating the client side templates in HAML.
*  Re-using templates on the server side for SEO and non-JS fallback.


To that end, I took the Andy Osmani's [ToDoMVC](http://addyosmani.github.com/todomvc/), specifically his [Backbone Boilerplates](https://github.com/addyosmani/backbone-boilerplates) project, which has a server example (Sinatra/Mongo) and tweaked it in several ways:

*  I used ActiveRecord instead of MongoDB.
*  Converted JS to CoffeeScript.
*  Set up Sinatra to serve Haml, Coffee, and Sass (with Compass support), similar to Rails's asset pipeline by using the very excellent [Sinatra Assetpack](https://github.com/rstacruz/sinatra-assetpack).
*  Used Haml to create the markup for client side templates, but used [Mustache](http://mustache.github.com/) (via [iCanHaz](http://icanhazjs.com/)) as far as Backbone was concerned.
*  Using the Haml/Mustache combination allows the same template to rendered on the client or server side (I'm not sure this is a good thing yet). The upside is that you can disable javascript and see the todos. I didn't bother making it work without JS, but it is a start.

Possible further areas to explore:

*  Authentication using [Warden](https://github.com/hassox/warden/).
*  Experiment with [Grape](https://github.com/intridea/grape) to power the API.

## Installing

* You'll need Ruby 1.9.2+ and the "Bundler" gem. (`gem install bundler`)
* Type `bundle install` to install the application dependencies.
* Type `bundle exec rackup`. The application should be successfully [running on port 9292.](http://localhost:9292)


I hope this helps someone. Feel free to shoot me any questions.
— [@philoye](http://twitter.com/philoye)

