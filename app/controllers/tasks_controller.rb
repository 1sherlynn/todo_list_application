class TasksController < ApplicationController

	before_action :find_task, only: [:show, :edit, :update, :destroy]
	#can use this in application controller to allow for it to persist in all pages.

	def index 
		if user_signed_in?
			if params[:category].blank?
				# @tasks = Task.where(:user_id => current_user.id).order("created_at DESC")
				@tasks = current_user.tasks.order("created_at DESC")
			else 
				@category = Category.find_by(name: params[:category])
				@tasks = @category.tasks.where(user: current_user).order("created_at DESC")
			end


			# @pending_task = Task.where("duedate BETWEEN ? AND ?", Date.today, Date.today.advance(:days => +7))
			# @overdue_task = Task.where("duedate < ?", Date.today)
			#learnt from vincet. Potentially add-on. 

		end
	end

	def show 
	end

	def new 
		@task = current_user.tasks.new
	end

	def create
		@task = current_user.tasks.new(task_params)   
		
		if @task.save 
			flash[:notice] = "Task successfully created."
			redirect_to root_path
		else
			flash[:error] = "Task not created, please try again."
			render 'new'
		end
	end

	def edit
	end

	def update 
		if @task.update(task_params)
			flash[:notice] = "Task successfully updated."
			redirect_to task_path(@task) 
		else 
			flash[:error] = "Task not updated, please try again."
			render 'edit'
		end
	end

	def destroy 
		@task.destroy
		flash[:notice] = "Task successfully destroyed."
		redirect_to root_path
	end

	def complete 
		@task = Task.find(params[:id])
		@task.update_attributes(:completed_at => Time.now)
		flash[:notice] = "Task completed. Well done!"
		redirect_to root_path 
	end

	private
	def task_params 
		params.require(:task).permit(:title, :description, :duedate, :priority)
	end

	def find_task
		@task = Task.find(params[:id])
	end

end
