class SurveyController < ApplicationController
	def bg
		# Keep track of session nbs
		unless checkSessionNb(0,true) then return end
		session[:completed] = false
		
		# Using session nbs as an identifier is a security vunlerability
		# Generate threads for new user
		session[:threads] = generateThreads
		session[:page] = 0 
		
		@form = :backgroundQuestions
		# TODO: Get background questions from db
		@sentence = "Background Questions"
		@questions = {:id1=>'Background Question1', :id2=>'Background Question2', :id3=>'Background Question3'}
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
		
		@form = :thread1
		@threadID = session[:threads][0]
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
		
		@form = :thread2
		@threadID = session[:threads][1]
		puts "----------------------here's the threadID: " + @threadID
		@answerID = 'answer-25820121'
		puts "----------------------here's the answerID: " + @answerID
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
		
		@form = :thread3
		@threadID = session[:threads][2]
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
		return ['16122957','13414663','28818597']
	end
end