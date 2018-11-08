class SurveyController < ApplicationController
	def bg
		@form = 'backgroundQuestions'
		# TODO: Get background questions from db
		@sentence = "Background Questions"
		@questions = {'id1'=>'Background Question1', 'id2'=>'Background Question2', 'id3'=>'Background Question3'} 
	end
	
	def createBg
		hash = params['backgroundQuestions'].permit!.to_h # security vunlerability! (permitting all params)
		# TODO: Save background info to db
		redirect_to survey_thread1_path
	end
	
	def thread1
		@form = 'thread1'
		# TODO: Get each thread sentence from db
		@sentence = 'Sentence 1'
		@questions = {'id1'=>'Sentence1 Question1', 'id2'=>'Sentence1 Question2', 'id3'=>'Sentence1 Question3'}
	end
	
	def create1
		redirect_to survey_thread2_path
	end
	
	def thread2
		@form = 'thread2'
		@sentence = 'Sentence 2' # Get thread2 sentence
		@questions = {'id1'=>'Sentence2 Question1', 'id2'=>'Sentence2 Question2', 'id3'=>'Sentence2 Question3'}
	end
	
	def create2
		# Save thread2 info
		redirect_to survey_thread3_path
	end
	
	def thread3
		@form = 'thread3'
		@sentence = 'Sentence 3' # Get thread3 sentence
		@questions = {'id1'=>'Sentence3 Question1', 'id2'=>'Sentence3 Question2', 'id3'=>'Sentence3 Question3'}
	end
	
	def create3
		# Save thread3 info
		redirect_to done_path
	end
end
