# Description
This project was adapted from [this tutorial](https://iridakos.com/tutorials/2013/12/07/creating-a-simple-todo-part-1.html) and the code it refers to. However, it was changed and customized to become a survey presented for developers to get their opinions about specific replies on StackOverflow questions. It is my first Ruby on Rails project and will be used to help in a [research project](https://sarahnadi.org/smr/lib-use/) I am helping with.

# Installing MySQL and connecting it to project
You can use the [installation guide](https://github.com/samasri/DevelopersSurvey/wiki/Installation-Guide) to set up Ruby on Rails on Nginx and Passenger and MySQL.

# Ruby on Rails Notes
Since this is my first project in Ruby on Rails, I've taken some notes of how things in RoR go [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/RubyOnRailsNotes.md).

# Assumptions
The assumptions we are aware of are documented [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/Assumptions.md)

# Database
The schema can be found [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/Database.png). The models can be initialized using `rake db:migrate:reset`.

# Features
* Uses Ruby on Rails framework
* Web scrapes information from StackOverFlow threads, highlights specific sentences, and allows users to answer question about each of the highlighted questions
* Uses a load balancer to pick threads that each user has to answer
* Presents the questions to users in forms and collects the information
* Keeps track of users through Session IDs to ensure seamless flow of the survey in case of interruptions (like mistakenly closing or reloading the page in the middle of the survey)

# Known Constraints
* Session numbers are used to identify users; this is a security vunlerability
* Saving information from the forms is done by blindly permitting all parameters. This is a security vunlerability
* Having the same sentence text multiple times in the same answer results in all matching sentence text to be highlighted
* The selected sentence (for highlighting) must appear with the same text in HTML. For example if the HTML of a sentence is: `Hello <span> world </span>`, this sentence cannot be selected for highlighting.
* If a user answers only the questions for only one sentence in a thread, the load balancing algorithms still counts this user as a respondent when calculating the threads with the highest number of respondants (although this respondent did not answer all the questions for that thread).
* If database is empty (no sentences or questions are populated), the load balancer gets into an infinite loop

# Test Suit
Test suit still not developed
