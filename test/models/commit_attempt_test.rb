require 'test_helper'

class CommitAttemptTest < ActiveSupport::TestCase
  test "commit_attempt belongs to repository" do
    assert_respond_to CommitAttempt.new, :repository
  end

  test "commit_attempt belongs to user" do
    assert_respond_to CommitAttempt.new, :user
  end

  test "commit_attempt has many policy_checks" do
    assert_respond_to CommitAttempt.new, :policy_checks
  end
end
