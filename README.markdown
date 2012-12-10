## What is this?

The ubiquitous [LocalTodos](http://documentcloud.github.com/backbone/examples/todos/index.html) backbone example code is great, but I wondered about:

*  Hooking it up to a REST API
*  Generating the client side templates in HAML.
*  Re-using templates on the server side for SEO and non-JS fallback.
*  Use progressive enhancement so we attach Backbone views to the DOM nodes created by the server, rather than emtpy the HTML and re-render on the client.

The progressive enhancement piece is cool because on page load, we are not fetching or re-rendering at all. All the events are properly bound to the elements already present. This should make things nice and fast, and improves SEO and accessibility. Derick Bailey wrote about this [technique a while ago](http://lostechies.com/derickbailey/2011/09/26/seo-and-accessibility-with-html5-pushstate-part-2-progressive-enhancement-with-backbone-js/).


To that end, I took the Andy Osmani's [ToDoMVC](http://addyosmani.github.com/todomvc/), specifically his [Backbone Boilerplates](https://github.com/addyosmani/backbone-boilerplates) project, which has a server example (Sinatra/Mongo) and tweaked it in several ways:

*  I used ActiveRecord/Sqlite instead of MongoDB.
*  Converted JS to CoffeeScript.
*  Set up Sinatra to serve Haml, Coffee, and Sass (with Compass support), similar to Rails's asset pipeline by using the very excellent [Sinatra Assetpack](https://github.com/rstacruz/sinatra-assetpack).
*  Used Haml to create the markup for client side templates, but used [Mustache](http://mustache.github.com/) (via [iCanHaz](http://icanhazjs.com/)) as far as Backbone was concerned.
*  Using the Haml/Mustache combination allows the same template to rendered on the client or server side (I'm not sure this is a good thing yet). The upside is that you can disable javascript and see the todos. I didn't bother making it work without JS, but it is a start.

## Installing

* You'll need Ruby 1.9.2+ and the "Bundler" gem. (`gem install bundler`)
* Type `bundle install` to install the application dependencies.
* Type `bundle exec rackup`. The application should be successfully [running on port 9292.](http://localhost:9292)


I hope this helps someone. Feel free to shoot me any questions.
— [@philoye](http://twitter.com/philoye)

