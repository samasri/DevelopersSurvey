# Description
This project was adapted from [this tutorial](https://iridakos.com/tutorials/2013/12/07/creating-a-simple-todo-part-1.html) and the code it refers to. However, it was changed and customized to become a survey presented for developers to get their opinions about specific replies on Github.

# Installing Ruby on Rails on Ubuntu 16.04 LTS
Use [this link](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/) to install Nginx + Passenger.
Use [this link](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-nginx-on-ubuntu-14-04#step-four-—-install-ruby) to install Ruby. Make sure to get the newest ruby version and not the one noted in the link. This project is based on Ruby 2.5.3.
Link passenger to the right ruby by doing the following:
* `sudo vim /etc/nginx/passenger.conf`
* set `passenger_ruby` to `/usr/bin/ruby`
Use [this link](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-nginx-on-ubuntu-14-04#step-seven-—-deploy) to install Rails and deploy app.

# Ruby on Rails Notes
Since this is my first project in Ruby on Rails, I've taken some notes of how things go [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/RubyOnRailsNotes.md).

# Database
The schema can be found [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/Database.png). The models can be initialized using the following commands:
```
rails generate model UserStatus UserID:string Status:integer
rake db:migrate RAILS_ENV=development
```

# Test Suit
Test suit still not developed