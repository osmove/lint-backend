class Linter < ApplicationRecord
  has_many :rules, dependent: :destroy
  has_many :rule_checks, dependent: :destroy
  has_many :policy_rules
end
