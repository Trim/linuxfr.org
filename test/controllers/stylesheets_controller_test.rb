require 'test_helper'

class StylesheetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in accounts 'visitor_0'
  end

  test 'should create stylesheet' do
    post stylesheet_url, params: {
      uploaded_stylesheet: fixture_file_upload('blue-smooth.scss', 'text/css')
    }
    assert_nil flash[:alert]
    assert flash[:notice]

    assert_redirected_to edit_stylesheet_url
  end

  test 'should get edit' do
    get edit_stylesheet_url
    assert_response :success
  end

  test 'should update stylesheet' do
    patch stylesheet_url, params: {
      stylesheet: 'contrib/blue-smooth'
    }
    assert_nil flash[:alert]
    assert flash[:notice]
    assert_redirected_to edit_stylesheet_url
  end

  test 'should destroy stylesheet' do
    delete stylesheet_url
    assert_nil flash[:alert]
    assert flash[:notice]
    assert_redirected_to edit_stylesheet_url
  end
end