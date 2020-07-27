# encoding: utf-8
class HomeController < ApplicationController
  def index
    @news = Node.home_listing(News)
    @diaries = Node.home_listing(Diary)
    @banner = Banner.random
  end
end
