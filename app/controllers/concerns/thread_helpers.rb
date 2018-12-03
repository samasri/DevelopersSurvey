module ThreadHelpers
	extend ActiveSupport::Concern
	
	included do
		helper_method :generateThreads
	end
	
	
	def generateThreads(maxResponses)
		# Get threads that have any responses (more than 0 responses)
		sql = 'SELECT thread_id, COUNT(user_id) as NumberOfResponses FROM (SELECT user_id, thread_id FROM responses as r INNER JOIN sentences as s on r.sentence_id = s.id GROUP BY user_id,  thread_id) as a GROUP BY thread_id;'
		threadResponsesTable = ActiveRecord::Base.connection.execute(sql)
		
		dummyThreadID = Sentence.where(['id = ?', -1])[0].thread_id
		threadResponses = {}
		threadResponsesTable.each do |record|
			unless record[0] < 0 or record[0] == dummyThreadID # Ignore invalid threads
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
		
		# Get top 3 threads with max nb of responses
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
		
		if threadIDs.count < maxResponses # if less than 3 threads are picked, increase the limit and try again
			logger.debug "Load balancing: all threads have " + maxResponses.to_s + " responses. Increasing by 5."
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