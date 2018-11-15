class ResponsesController < ApplicationController
	def new
		@response = :response
		session[:picked_sentence] = params[:picked_sentence][:sentence_id]
		questions = Question.where ['qtype = ?', :sg]
		@questions = {}
		questions.each do |question|
			@questions[question.id] = question.question_text
		end
	end
	
	def create
		# TODO: Save background info to db
		sentence_id = session[:picked_sentence]
		user_id = session.id
		answers = params['responses'].permit!.to_h # questionID --> answer
		puts '--------------- Thread Questions --------------'
		puts 'UserID: ' + user_id
		puts 'SentenceID: ' + sentence_id
		puts 'QuestionID --> Response'
		answers.each do |id, answer|
			puts id + '-->' + answer
		end
		puts '------------------------------------------------'
		redirect_to survey_thread1_path
	end
end
