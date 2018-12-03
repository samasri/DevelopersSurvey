module FetchQuestions
	extend ActiveSupport::Concern
	
	included do
		helper_method :fetchQuestions
	end

	# Creates and populate the member fields: questions and questionRequirement
	def fetchQuestions(condition)
		questions = Question.where condition
		@questions = {}
		@questionRequirement = {}
		@questionType = {}
		questions.each do |question|
			@questions[question.id] = question.question_text
			@questionRequirement[question.id] = question.mandatory
			@questionType[question.id] = question.responseType
		end
	end
end