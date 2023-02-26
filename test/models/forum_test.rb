# encoding: utf-8
require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  test "user with positive karma can create diary" do
    diary = diaries(:lorem_cc_licensed).dup;
    assert diary.creatable_by?(diary.owner.account);
    assert diary.save();
  end

  test "user with zero karma cannot create diary" do
    diary = diaries(:lorem_cc_licensed).dup;
    diary.owner = users(:visitor_zero_karma);
    assert_not diary.creatable_by?(diary.owner.account);
    assert diary.save(), "Diary model were not saved";
  end
end
