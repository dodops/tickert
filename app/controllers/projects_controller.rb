class ProjectsController < ApplicationController
  def index	
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
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

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)

    flash[:notice] = "Project has been updated."
    redirect_to @project
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
