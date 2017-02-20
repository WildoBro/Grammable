class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank?

    @gram.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize} :(", status: status
  end

end
