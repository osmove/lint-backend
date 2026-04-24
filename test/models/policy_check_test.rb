require 'test_helper'

class PolicyCheckTest < ActiveSupport::TestCase
  test 'set_offense_count sums errors and warnings' do
    pc = PolicyCheck.new(error_count: 5, warning_count: 3)
    pc.set_offense_count
    assert_equal 8, pc.offense_count
  end

  test 'set_offense_count handles nil counts' do
    pc = PolicyCheck.new(error_count: nil, warning_count: nil)
    pc.set_offense_count
    assert_equal 0, pc.offense_count
  end

  test 'set_fixable_offense_count sums fixable errors and warnings' do
    pc = PolicyCheck.new(fixable_error_count: 2, fixable_warning_count: 4)
    pc.set_fixable_offense_count
    assert_equal 6, pc.fixable_offense_count
  end

  test 'policy_check has many rule_checks' do
    assert_respond_to PolicyCheck.new, :rule_checks
  end
end
