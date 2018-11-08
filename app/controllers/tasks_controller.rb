class TasksController < ApplicationController
	def new
		@task = Task.new
  end

	def create
		# @task = Task.create(task_params)
		# redirect_to new_thread1_path, remote: true
		# @task = Task.new
		# render partial: 'task_form', locals: {task: @task}
		redirect_to root_path
	end

	private
	def task_params
		params.require(:task).permit(:title, :note, :completed)
	end
end
