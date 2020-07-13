# encoding: UTF-8
class StatisticsController < ApplicationController

  def tracker
    @stats = Statistics::Tracker.new
  end

  def prizes
    @month = params[:month]
    @stats = Statistics::Prizes.new(@month)
  end

  def users
    @stats = Statistics::Users.new
  end

  def anonymous
    @stats = Statistics::Anonymous.new
  end

  def collective
    @stats = Statistics::Collective.new
  end

  def top
    @stats = Statistics::Tops.new
  end

  def moderation
    @stats = Statistics::Moderation.new
  end

  def redaction
    @stats = Statistics::Redaction.new
  end

  def contents
    @stats = Statistics::Contents.new
  end

  def comments
    @stats = Statistics::Comments.new
    @contents = Statistics::Contents.new
  end

  def tags
    @stats = Statistics::Tags.new
    @contents = Statistics::Contents.new
  end

  def applications
    @stats = Statistics::Applications.new
  end
end
