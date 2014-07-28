class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :find_project, only: [:show, :update, :edit, :destroy]

  def index	
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project has been created."
    else
      flash[:notice] = "Project has not been created."
      render :new
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  def update
    @project.update(project_params)

    flash[:notice] = "Project has been updated."
    redirect_to @project
  end

  private

  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "The project you were looking" +
      " for could not be found."
    redirect_to projects_path
  end

  def authorize_admin!
    require_signin!
    unless current_user.admin?
      redirect_to root_path, notice: "You must be an admin to do that."
    end 
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
