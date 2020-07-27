# encoding: utf-8
class HomeController < ApplicationController
  def index
    @news = Node.home_listing(News)
    @diaries = Node.home_listing(Diary)
    @posts = Node.home_listing(Post)
    @polls = Node.home_listing(Poll).limit(1)
    @bookmarks = Node.home_listing(Bookmark)
    @wiki_pages = Node.home_listing(WikiPage)
    @banner = Banner.random
  end
end
