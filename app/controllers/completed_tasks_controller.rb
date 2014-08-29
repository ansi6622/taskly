class CompletedTasksController < ApplicationController
  def index
    @task_list = TaskList.find(params[:task_list_id])
  end
end