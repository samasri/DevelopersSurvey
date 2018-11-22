class SurveyController < ApplicationController
	include AddResponse
	
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true) then return end
		session[:completed] = false
		
		# Generate threads + initialize session for new user
		session[:threads] = generateThreads
		session[:page] = 0
		session[:answeredSentences] = Array.new
		
		# Get background questions from db
		questions = Question.where ["qtype = ?", :bg]
		@questions = {}
		questions.each do |question|
			@questions[question.id] = question.question_text
		end
	end
	
	def createBg
		# Keep track of session nbs
		unless checkSessionNb(0,false) then return end
		updateSessionNb(1)
		
		# TODO: Save background info to db
		answers = params[:backgroundQuestions].permit!.to_h
		userID = session.id
		addResponse('Background Questions', answers, userID)
		redirect_to survey_thread1_path
	end
	
	def thread1
		unless checkSessionNb(1,true) then return end
		
		@form = :thread1
		@user_id = session[:id]
		@threadID = session[:threads][0]
		@sentences = getSentences @threadID
		@nextPath = survey_thread1_path
		render :layout => false
	end
	
	def proceed1
		# Keep track of session nbs
		unless checkSessionNb(1,false)then return end
		updateSessionNb(2)
		
		redirect_to survey_thread2_path
	end
	
	def thread2
		unless checkSessionNb(2,true) then return end
		
		@form = :thread2
		@threadID = session[:threads][1]
		@sentences = getSentences @threadID
		@nextPath = survey_thread2_path
		render :layout => false
	end
	
	def proceed2
		# Keep track of session nbs
		unless checkSessionNb(2,false) then return end
		updateSessionNb(3)
		
		# Save thread2 info
		redirect_to survey_thread3_path
	end
	
	def thread3
		unless checkSessionNb(3,true) then return end
		
		@form = :thread3
		@threadID = session[:threads][2]
		@sentences = getSentences @threadID
		@nextPath = survey_thread3_path
		render :layout => false
	end
	
	def proceed3
		# Keep track of session nbs
		unless checkSessionNb(3,false) then return end
		deleteSessionNb()
		
		# Save thread3 info
		redirect_to done_path
	end
	
	private
	def checkSessionNb(pageNb, isGet)
		if session.key? :page and not session[:completed]
			if session[:page] == pageNb then 
				return true
			else
				path = pageNbToPath(session[:page])
				redirect_to path
				return false
			end
		else
			if isGet and pageNb == 0 
				# If new user on the first page, return true so that calling method does not exit
				return true 
			else
				redirect_to pageNbToPath(0)
				return false
			end
		end
	end
	
	def pageNbToPath(pageNb)
		if pageNb == 0
			return survey_bg_path
		elsif pageNb == 1
			return survey_thread1_path
		elsif pageNb == 2
			return survey_thread2_path
		elsif pageNb == 3
			return survey_thread3_path
		end
	end
	
	def updateSessionNb(pageNb)
		session[:page] = pageNb
	end
	
	def deleteSessionNb
		session[:completed] = true
	end
	
	def generateThreads
		sentences = Sentence.select(:thread_id).distinct.to_a
		threadIDs = []
		sentences.each do |sentence|
			threadIDs.push(sentence.thread_id.to_s)
		end
		return threadIDs
	end
	
	def getSentences(threadID)
		sentences = Sentence.where ['thread_id = ?', threadID]
		answerIDs = {} # Map: answer_id --> [sentence_id, sentence_text]
		sentences.each do |sentence|
			unless answerIDs.key? sentence.answer_id 
				answerIDs[sentence.answer_id] = [].to_set
			end
			answerIDs[sentence.answer_id].add([sentence.id,sentence.sentence_text])
		end
		return answerIDs
	end
end