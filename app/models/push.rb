class Push < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  has_many :commits
  has_many :commit_attempts
  has_many :policy_checks
  has_many :rules_checks
end
