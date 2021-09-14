# encoding: UTF-8
class Moderation::CommentsController < ModerationController
  respond_to :html

  def index
    @comments = Comment.latest.
      page(params[:page]).
      order(created_at: :desc)
  end
end
