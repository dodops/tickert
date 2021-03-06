class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :find_ticket

  def create
    @comment = @ticket.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      flash[:alert] = "Comment has not been created."
      render template: "tickets/show"
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comments_params
    params.require(:comment).permit(:text)
  end
end
