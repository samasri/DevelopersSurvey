Rails.application.routes.draw do
	root to: 'pages#home'
	resources :tasks,  except:  [:index]
	get '/survey/bg', to: 'survey#bg'
	post '/survey/bg', to: 'survey#createBg'
	
	get '/survey/thread1', to: 'survey#thread1'
	post '/survey/thread1', to: 'survey#create1'
	
	get '/survey/thread2', to: 'survey#thread2'
	post '/survey/thread2', to: 'survey#create2'
	
	get '/survey/thread3', to: 'survey#thread3'
	post '/survey/thread3', to: 'survey#create3'
	
	get '/done', to: 'survey#exit'
end
