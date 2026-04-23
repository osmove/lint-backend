require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without username" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.save, "Saved user without a username"
  end

  test "should not save user without email" do
    user = User.new(username: "testuser", password: "password123")
    assert_not user.save, "Saved user without an email"
  end

  test "username should be unique" do
    User.create!(username: "uniqueuser", email: "uniqueuser@example.com", password: "password123")
    user2 = User.new(username: "uniqueuser", email: "another@example.com", password: "password123")
    assert_not user2.valid?, "Duplicate username should not be valid"
  end

  test "email should be unique" do
    User.create!(username: "user1", email: "same@example.com", password: "password123")
    user2 = User.new(username: "user2", email: "same@example.com", password: "password123")
    assert_not user2.valid?, "Duplicate email should not be valid"
  end

  test "login returns username or email" do
    user = User.new(username: "testuser", email: "test@example.com")
    assert_equal "testuser", user.login
  end

  test "greet returns time-appropriate greeting" do
    user = User.new(username: "testuser")
    greeting = user.greet
    assert_match(/Good (morning|afternoon|evening|night), testuser/, greeting)
  end

  test "name returns full name" do
    user = User.new(first_name: "John", last_name: "Doe")
    assert_equal "John Doe", user.name
  end

  test "name_or_username falls back to username" do
    user = User.new(username: "johndoe")
    assert_equal "johndoe", user.name_or_username
  end

  test "to_param returns lowercase username" do
    user = User.new(username: "JohnDoe")
    assert_equal "johndoe", user.to_param
  end

  test "set_defaults assigns plan and seats" do
    user = User.new(username: "newuser", email: "new@example.com", password: "password123")
    user.valid?
    user.send(:set_defaults)
    assert_equal 1, user.number_of_seats
  end

  test "generates authentication token before save" do
    user = User.new(username: "tokenuser", email: "token@example.com", password: "password123")
    user.valid?
    user.send(:ensure_authentication_token)
    assert_not_nil user.authentication_token
  end
end
