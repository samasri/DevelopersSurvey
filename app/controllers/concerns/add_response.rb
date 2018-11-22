module AddResponse
	extend ActiveSupport::Concern
	
	included do
		helper_method :addResponse
	end
	
	
	def addResponse(questionSet, answers, userID, sentenceID = -1)
		logger.debug "--------------- " + questionSet + " --------------"
		logger.debug 'SentenceID: ' + sentenceID.to_s
		logger.debug 'UserID: ' + userID
		answers.each do |questionID, answer|
			logger.debug questionID + ' --> ' + answer
			begin
				Response.create(question_id: questionID, user_id: userID, sentence_id: sentenceID, response: answer)
			rescue ActiveRecord::RecordNotUnique
				logger.error 'Record not unique'
			rescue ActiveRecord::InvalidForeignKey
				logger.error 'Invalid foreign key'
			rescue
				logger.error 'Some other error occured'
			end
		end
		logger.debug "-----------------------------------------------"
		
	end
	
end