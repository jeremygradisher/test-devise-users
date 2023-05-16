require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "username should be required" do
    user = User.new(email: "example@example.com", password: "password")
    assert_not user.valid?
    assert user.errors[:username].any?
  end
end
