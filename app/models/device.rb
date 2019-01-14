class Device < ApplicationRecord
  belongs_to :user, optional: true
  has_many :commit_attempts
  has_many :policy_checks
  has_many :rules_checks

  is_impressionable
  self.inheritance_column = :_type_disabled

end
