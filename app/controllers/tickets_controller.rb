class TicketsController < ApplicationController
  before_action :find_project
  before_action :require_signin!
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error

  def new
    @ticket = @project.tickets.build
    @ticket.assets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:notice] = "Ticket has not been created."
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:notice] = "Ticket has not been updated."
      render action: "edit"
    end
  end

  def show
    @comment = @ticket.comments.build
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
    redirect_to @project
  end

  private
  def authorize_update!
    if !current_user.admin? && cannot?("edit tickets".to_sym, @project)
      redirect_to @project, notice: "You cannot edit tickets on this project."
    end
  end
  def handle_error
    flash[:notice] = "The project you were looking for could not be found."
    redirect_to root_path
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, assets_attributes: [:asset])
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def find_project
    @project = Project.for(current_user).find(params[:project_id])
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:notice] = "You cannot create tickets on this project."
      redirect_to @project
    end
  end
end
