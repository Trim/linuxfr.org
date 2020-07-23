# encoding: utf-8
class HomeController < ApplicationController
  def index
    @news  = Node.public_listing(News, "created_at").limit(5)
    render :index, layout: 'home'
  end
end
