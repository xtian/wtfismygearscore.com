# frozen_string_literal: true
class CommentsController < ApplicationController
  def create
    comment = Character.find_by!(params.permit(:region, :realm, :name))
      .create_comment(comment_params)

    CommentPostedJob.perform_later(comment) if comment.valid?
    redirect_back(redirect_options(comment))
  end

  private

  def comment_params
    params.require(:comment).permit(:poster_name, :body).tap do |hash|
      hash[:poster_ip_address] = request.remote_ip
      hash[:referrer] = request.referer
      hash[:user_agent] = request.user_agent
    end
  end

  def redirect_options(comment)
    {
      fallback_location: :root,
      alert: (comment.errors.messages.values.flatten if comment.invalid?),
      notice: (t('comment.posted_successfully') if comment.valid?)
    }
  end
end
