class SurveyController < ApplicationController
	include AddResponse
	include FetchQuestions
	MAX_RESPONSES = 3
	
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true) then return end
		session[:completed] = false
		
		# Generate threads + initialize session for new user
		session[:threads] = generateThreads(MAX_RESPONSES) # The threads that this user will be assessing 
		session[:page] = 0 # To keep track of completed pages and threads
		session[:answeredSentences] = [] # IDs of all sentences whose questions have already been answered
		session[:toAnswer] = [] # IDs of sentences whose questions should be answered so far to go to next page
		
		# Initialize member fields
		fetchQuestions(["qtype = ?", :bg])
		@title = 'Background Questions'
		@formName = :backgroundQuestions
	end
	
	def createBg
		# Keep track of session nbs
		unless checkSessionNb(0,false) then return end
		updateSessionNb(1)
		
		answers = params[:backgroundQuestions].permit!.to_h
		userID = session.id
		addResponse('Background Questions', answers, userID)
		redirect_to survey_instructions_path
	end
	
	def instructions
		unless checkSessionNb(1,true) then return end
	end
	
	def proceedToThreads
		unless checkSessionNb(1,false) then return end
		updateSessionNb(2)
		redirect_to survey_thread1_path
	end
	
	def thread1
		unless checkSessionNb(2,true) then return end
		
		@form = :thread1
		@user_id = session[:id]
		@threadID = session[:threads][0]
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID # Remove duplicates
		@nextPath = survey_thread1_path
		render :layout => false
	end
	
	def proceed1
		# Keep track of session nbs
		unless checkSessionNb(2,false)then return end
		updateSessionNb(3)
		
		redirect_to survey_thread2_path
	end
	
	def thread2
		unless checkSessionNb(3,true) then return end
		
		@form = :thread2
		@threadID = session[:threads][1]
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID
		@nextPath = survey_thread2_path
		render :layout => false
	end
	
	def proceed2
		# Keep track of session nbs
		unless checkSessionNb(3,false) then return end
		updateSessionNb(4)
		
		redirect_to survey_thread3_path
	end
	
	def thread3
		unless checkSessionNb(4,true) then return end
		
		@form = :thread3
		@threadID = session[:threads][2]
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID
		@nextPath = survey_thread3_path
		render :layout => false
	end
	
	def proceed3
		# Keep track of session nbs
		unless checkSessionNb(4,false) then return end
		updateSessionNb(5)
		
		
		redirect_to survey_thread4_path
	end
	
	
	def thread4
		unless checkSessionNb(5,true) then return end
		
		@form = :thread4
		@threadID = Sentence.find(-1).thread_id
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID
		@nextPath = survey_thread4_path
		render :layout => false
	end
	
	def proceed4
		# Keep track of session nbs
		unless checkSessionNb(5,false) then return end
		updateSessionNb(6)
		
		
		redirect_to survey_exit_path
	end
	
	def exit
		unless checkSessionNb(6,true) then return end
		
		# Initialize member fields
		fetchQuestions(["qtype = ?", :eg])
		@title = 'Feedback'
		@formName = :backgroundQuestions
	end
	
	def proceedToThankyou
		unless checkSessionNb(6,false) then return end
		updateSessionNb(7)
		
		redirect_to done_path
	end
	
	def thankyou
		unless checkSessionNb(7,true) then return end
		deleteSessionNb()
		
		@sessionNb = session.id
	
	end
	
	def testLoadBalancing
		@threadIDs = generateThreads(MAX_RESPONSES)
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
			return survey_instructions_path
		elsif pageNb == 2
			return survey_thread1_path
		elsif pageNb == 3
			return survey_thread2_path
		elsif pageNb == 4
			return survey_thread3_path
		elsif pageNb == 5
			return survey_thread4_path
		elsif pageNb == 6
			return survey_exit_path
		end
	end
	
	def updateSessionNb(pageNb)
		session[:page] = pageNb
	end
	
	def deleteSessionNb
		session[:completed] = true
	end
	
	def generateThreads(maxResponses)
		# Get threads that have any responses (more than 0 responses)
		sql = 'SELECT thread_id, COUNT(user_id) as NumberOfResponses FROM (SELECT user_id, thread_id FROM responses as r INNER JOIN sentences as s on r.sentence_id = s.id GROUP BY user_id,  thread_id) as a GROUP BY thread_id;'
		threadResponsesTable = ActiveRecord::Base.connection.execute(sql)
		
		threadResponses = {}
		threadResponsesTable.each do |record|
			unless record[0] < 0 # Ignore dummy thread answers and 
				threadResponses[record[0]] = record[1]
			end
		end
		
		# Add all other threads (that has no responses) to the threadResponses map
		sentences = Sentence.select(:thread_id).distinct.to_a
		sentences.each do |sentence|
			id = sentence.thread_id
			if not threadResponses.key? id
				threadResponses[id] = 0
			end
		end
		
		threadIDs = []
		
		for i in 1..3 do
			maxThreadID = -1
			maxThreadResponses = -1
			threadResponses.each do |threadID, nbOfResponses|
				if nbOfResponses > maxThreadResponses and nbOfResponses < maxResponses
					maxThreadResponses = nbOfResponses
					maxThreadID = threadID
				end
			end
			if maxThreadID != -1
				threadResponses.delete(maxThreadID)
				threadIDs.push(maxThreadID)
			end
		end
		
		if threadIDs.count < 3
			logger.debug "Load balancing: all threads have " + MAX_RESPONSES.to_s + " responses. Increasing by 5."
			neededThreads = 3 - threadIDs.count
			threadIDs += generateThreads(maxResponses + 5)[0..(neededThreads - 1)]
		end
		return threadIDs
	end
	
	def getThreadSentenceMapping(threadID)
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
	
	def getSentenceIDs(threadID)
		sentences = Sentence.where ['thread_id = ?', threadID]
		sentenceIDs = Set.new
		sentences.each do |sentence|
			sentenceIDs.add(sentence.id)
		end
		return sentenceIDs.to_a
	end
end