class SurveyController < ApplicationController
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true) then return end
		
		# Generate threads for new user
		threads = generateThreads
		UserStatus.create(sessionNb: session.id, pageNb: 0, thread1: threads[0], thread2: threads[1], thread3: threads[2]) # Using session nbs as an identifier is a security vunlerability
		
		@form = 'backgroundQuestions'
		# TODO: Get background questions from db
		@sentence = "Background Questions"
		@questions = {'id1'=>'Background Question1', 'id2'=>'Background Question2', 'id3'=>'Background Question3'} 
	end
	
	def createBg
		# Keep track of session nbs
		unless checkSessionNb(0,false) then return end
		updateSessionNb(1)
		
		# hash = params['backgroundQuestions'].permit!.to_h # security vunlerability! (permitting all params)
		# TODO: Save background info to db
		redirect_to survey_thread1_path
	end
	
	def thread1
		unless checkSessionNb(1,true) then return end
		
		user = UserStatus.find(session.id)
		@form = 'thread1'
		@threadID = user.thread1.to_s
		@answerID = 'answer-16123196'
		@sentenceText = 'string content gets'
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
		
		user = UserStatus.find(session.id)
		@form = 'thread2'
		@threadID = user.thread2.to_s
		@answerID = 'answer-25820121'
		@sentenceText = 'In the example below'
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
		
		user = UserStatus.find(session.id)
		@form = 'thread3'
		@threadID = user.thread3.to_s
		@answerID = 'answer-39967496'
		@sentenceText = 'If you are on Ubuntu'
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
		begin 
			user = UserStatus.find(session.id)
			if user.pageNb == pageNb
				return true
			else
				path = pageNbToPath(user.pageNb)
				redirect_to path
				return false
			end
		rescue
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
		user = UserStatus.find(session.id)
		puts "------------------I am updating: " + user.pageNb.to_s
		user.pageNb = pageNb
		user.save
	end
	
	def deleteSessionNb
		user = UserStatus.find(session.id)
		user.delete
	end
	
	def generateThreads
		return ['16122957','13414663','28818597']
	end
end