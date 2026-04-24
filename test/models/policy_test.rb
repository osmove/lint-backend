require 'test_helper'

class PolicyTest < ActiveSupport::TestCase
  test 'policy has many policy_rules' do
    assert_respond_to Policy.new, :policy_rules
  end

  test 'policy belongs to user' do
    assert_respond_to Policy.new, :user
  end

  test 'policy has many policy_checks' do
    assert_respond_to Policy.new, :policy_checks
  end
end
