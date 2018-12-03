class TestController < ApplicationController
	include ThreadHelpers
	
	def testLoadBalancing
		@threadIDs = generateThreads(MAX_RESPONSES)
	end
	
	def testSentenceHighlighting
		# Get threadID
		@threadID = params[:id]
		unless @threadID
			@out = 'No thread ID is found'
			return
		end
		
		@form = :thread1
		@user_id = session[:id]
		@sentences = getThreadSentenceMapping @threadID
		session[:toAnswer] += getSentenceIDs @threadID
		session[:toAnswer] &= getSentenceIDs @threadID # Remove duplicates
		@nextPath = root_path
		render :layout => false
		
	end
end
