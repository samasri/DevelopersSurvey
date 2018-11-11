class SurveyController < ApplicationController
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true)
			return
		end
		UserStatus.create(UserID: session.id, Page: 0) # Using session nbs as an identifier is a security vunlerability
		
		@form = 'backgroundQuestions'
		# TODO: Get background questions from db
		@sentence = "Background Questions"
		@questions = {'id1'=>'Background Question1', 'id2'=>'Background Question2', 'id3'=>'Background Question3'} 
	end
	
	def createBg
		# Keep track of session nbs
		unless checkSessionNb(0)
			return
		end
		updateSessionNb(1)
		
		# hash = params['backgroundQuestions'].permit!.to_h # security vunlerability! (permitting all params)
		# TODO: Save background info to db
		redirect_to survey_thread1_path
	end
	
	def thread1
		unless checkSessionNb(1)
			return
		end
		@form = 'thread1'
		@threadID = '16122957'
		@answerID = 'answer-16123196'
		@sentenceText = 'string content gets'
		render :layout => false
	end
	
	def create1
		# Keep track of session nbs
		unless checkSessionNb(1)
			return
		end
		updateSessionNb(2)
		
		redirect_to survey_thread2_path
	end
	
	def thread2
		unless checkSessionNb(2)
			return
		end
		@form = 'thread2'
		@sentence = 'Sentence 2' # Get thread2 sentence
		@questions = {'id1'=>'Sentence2 Question1', 'id2'=>'Sentence2 Question2', 'id3'=>'Sentence2 Question3'}
	end
	
	def create2
		# Keep track of session nbs
		unless checkSessionNb(2)
			return
		end
		updateSessionNb(3)
		
		# Save thread2 info
		redirect_to survey_thread3_path
	end
	
	def thread3
		unless checkSessionNb(3)
			return
		end
		@form = 'thread3'
		@sentence = 'Sentence 3' # Get thread3 sentence
		@questions = {'id1'=>'Sentence3 Question1', 'id2'=>'Sentence3 Question2', 'id3'=>'Sentence3 Question3'}
	end
	
	def create3
		# Keep track of session nbs
		unless checkSessionNb(3)
			return
		end
		deleteSessionNb()
		
		# Save thread3 info
		redirect_to done_path
	end
	
	private
	def checkSessionNb(pageNb, isFirstUser=false)
		begin 
			user = UserStatus.find_by! UserID: session.id
			if user.Page == pageNb
				return true
			else
				path = pageNbToPath(user.Page)
				redirect_to path
				return false
			end
		rescue
			return true if isFirstUser # If first page, return true so that calling method does not exit
			return false
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
		user = UserStatus.find_by! UserID: session.id
		user.Page = pageNb
		user.save
	end
	
	def deleteSessionNb
		user = UserStatus.find_by! UserID: session.id
		user.delete
	end
end