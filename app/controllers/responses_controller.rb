class ResponsesController < ApplicationController
	include AddResponse
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
		sentenceID = session[:picked_sentence]
		userID = session.id
		
		answers = params['responses'].permit!.to_h # questionID --> answer
		addResponse('Thread Questions', answers, userID, sentenceID)
		
		redirect_to survey_thread1_path
	end
end
