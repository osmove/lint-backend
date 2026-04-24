require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test 'generate_secret_key returns a hex string' do
    repo = Repository.new
    key = repo.generate_secret_key
    assert_not_nil key, 'generate_secret_key should return a value'
    assert_equal 60, key.length, 'Secret key should be 60 hex characters (30 bytes)'
    assert_match(/\A[a-f0-9]+\z/, key, 'Secret key should be hex characters only')
  end

  test 'repository belongs to user' do
    assert_respond_to Repository.new, :user
  end

  test 'repository has many commits' do
    assert_respond_to Repository.new, :commits
  end

  test 'repository has many commit_attempts' do
    assert_respond_to Repository.new, :commit_attempts
  end
end
