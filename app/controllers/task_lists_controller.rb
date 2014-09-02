class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.order(:name)
  end

  def show
    @task_list = TaskList.find(params[:id])
  end

  def new
    @task_list = TaskList.new
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])

    if @task_list.update(allowed_params)
      flash[:notice] = "Task List was updated successfully"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task_list = TaskList.find(params[:id])
    @task_list.destroy!
    flash[:notice] = "Task List was deleted successfully"
    redirect_to root_path
  end

  def create
    @task_list = TaskList.new(allowed_params)

    if @task_list.save
      flash[:notice] = "Task List was created successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def allowed_params
    params.require(:task_list).permit(:name)
  end

end