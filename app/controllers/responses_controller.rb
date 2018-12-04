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
	
	def newLastResponse
		session[:picked_thread] = params[:picked_thread][:thread_id]
		fetchQuestions(["qtype = ?", :lg])
	end
	
	def createLastResponse
		threadID = session[:picked_thread]
		dummySentenceID = Sentence.where(["thread_id = ? and answer_id = ?", threadID, -1])[0].id
		userID = session.id
		answers = params['lastResponse'].permit!.to_h # questionID --> answer
		addResponse('Thread Questions', answers, userID, dummySentenceID)
		
		redirect_to survey_thread1_path
	end
end
