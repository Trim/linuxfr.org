# encoding: UTF-8
class Moderation::CommentsController < ModerationController
  respond_to :html

  def index
    @comments = Comment.moderation
  end
end
