class ResponsesController < ApplicationController
	include AddResponse
	include FetchQuestions
	
	def new
		@response = :response
		session[:picked_sentence] = params[:picked_sentence][:sentence_id]
		
		# Get background questions from db and store them in the member fields: questions and questionRequirement
		fetchQuestions(["qtype = ?", :sg])
	end
	
	def create
		sentenceID = session[:picked_sentence]
		userID = session.id
		
		answers = params['responses'].permit!.to_h # questionID --> answer
		addResponse('Thread Questions', answers, userID, sentenceID)
		
		redirect_to survey_thread1_path
	end
end
