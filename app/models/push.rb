class Push < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  has_many :commits, dependent: :destroy
  has_many :commit_attempts, dependent: :destroy
  has_many :policy_checks, dependent: :destroy
end
