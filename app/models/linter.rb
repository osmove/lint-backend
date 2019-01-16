class Linter < ApplicationRecord
  has_many :rules
  has_many :rule_checks
  has_many :policy_rules

end
