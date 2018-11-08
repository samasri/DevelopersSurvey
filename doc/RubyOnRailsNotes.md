# Ruby on Rails Notes

## Miscellaneous `rails` commands
* Create new project: `rails new [name-of-project]`
* Run server: `rails server`

## Project Dependencies
* Add gems (or libraries) to the `Gemfile`
* Go to `apps/assets/javascripts/application.js` and add/or remove the required javascript dependencies
	* things like `//= require bootstrap` can be added
* Go to `apps/assets/stylesheets/application.css.scss` and add/or remove the required stylesheet dependencies
	* things like `@import bootstrap` can be added
* Anything added to those `application.js` and `application.css.scss` would be added in the view by the triggering following lines: `stylesheet_link_tag    "application", media: "all"` and `javascript_include_tag "application"`

## Module
* Create a model or a database table: `rails generate model [name-of-table] [columnName]:[type] [column2Name]:[type]...`
	* Example: `rails generate model Task title:string note:text completed:date` creates a table named `Task` with 3 columns: Title, Note, and Completed
* `rails console` opens a Ruby interpreter console that can be used to manipulate the database
* Run `rake db:migrate RAILS_ENV=development` to apply the generated model into an actual database (SQLLite3 is the default database used)

## View
## Types of Views
* View can be either a haml page(.haml) or a javaScript page(.js.erb)
* View must belong to a controller and placed in _app/view/[controller-name]_
* Views all have a generic page, from which each separate view is customized. That generic view is placed in _app/view/layouts/application.html.haml_
* In that generic view, `= yield` will be replaced by the customized page content from the view specific for each controller
* Controllers can also have partial views. These are parts of a view that are used frequently. In order to use those partials in a normal view, add the following ruby code: `render partial: '[partial-name]'` 

### haml General Rules
* use indentation to express hierarchy skipping end tags etc
* ruby commands start with -
* ruby embedded content starts with =
* html tags start with %
* use # for setting id’s to your html elements
* use . for setting css classes to your html elements


## Routes
* _config/routes.rb_ is responsible to route every sub-URI path to the right controller and view
* `root to: '[controller-name]#[instance-name]` links the main URI of the website to the right controller and view. For example: `root to: pages#home` links the root page (_/_) to the following actions:
	* Calling the method with the same name as the indicated view (`home`) inside the `PagesController` class inside `app/controllers/pages_controllers.rb`.
	* Displaying the view inside `app/view/pages/home.*` if the file exists to the user
* Routing can also happen in _routes.rb_ by other commands, such as:
	* `get '/survey/', to: 'survey#index'`: links _/survey/_ to the index view in the survey controller
	* `resources :tasks,  except:  [:index]`: assumes tasks is a resource and automatically links URIs to manipulate that resource. Such as _/tasks/new_ to `tasks#new` and _/tasks/:id_ to `tasks#show`.
* Run `rake routes` to see a table summary of all route resolution

## Controllers
* `rails generate controller [controller-name]` generates a controller
* Generates `[controller-name]_controller.rb` in `app/controllers/` directory.
* Controller contains methods used to:
	* Set variables used by the corresponding views
	* Use data entered by the user in the view to edit the module