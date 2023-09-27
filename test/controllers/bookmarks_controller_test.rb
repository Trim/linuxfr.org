require 'test_helper'

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should list bookmarks' do
    get bookmarks_url
    assert_response :success
  end

  test 'should show bookmark' do
    get bookmarks_url(bookmarks(:one), format: :html)
    assert_response :success
    assert_nil flash[:alert]
  end

  test 'should get new' do
    sign_in accounts 'maintainer_0'
    get new_bookmark_url
    assert_response :success
  end

  test 'should preview bookmark' do
    sign_in accounts 'maintainer_0'
    assert_no_difference('Bookmark.count') do
      post bookmarks_url,
           params: {
             bookmark: {
               title: 'Hello world',
               link: 'http://example.com'
             },
             tags: 'foo, bar',
             commit: 'Prévisualiser'
           }
    end
    assert_response :success
  end

  test 'should create bookmark' do
    sign_in accounts 'maintainer_0'
    assert_difference('Bookmark.count') do
      post bookmarks_url,
           params: {
             bookmark: {
               title: 'Hello world',
               link: 'http://example.com',
               lang: 'fr'
             },
             tags: 'foo, bar'
           }
    end
    assert_redirected_to user_bookmark_url(users('maintainer_0'), Bookmark.last)
  end

  test 'should get edit' do
    sign_in accounts 'maintainer_0'
    get edit_user_bookmark_url(users('editor_0'), bookmarks(:one))
    assert_redirected_to user_bookmark_url(users('visitor_0'), Bookmark.last)
  end

  test 'should update bookmark' do
    sign_in accounts 'maintainer_0'
    patch user_bookmark_url(users('editor_0'), bookmarks(:one)),
          params: {
            bookmark: {
              title: 'Hello world',
              link: 'http://example.com'
            }
          }
    assert_redirected_to user_bookmark_url(users('visitor_0'), bookmarks(:one))
  end

  test 'should destroy bookmark' do
    sign_in accounts 'maintainer_0'
    delete user_bookmark_url(users('editor_0'), bookmarks(:one))
    assert_redirected_to user_bookmark_url(users('visitor_0'), bookmarks(:one))
  end
end
