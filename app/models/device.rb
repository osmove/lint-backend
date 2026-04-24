class Device < ApplicationRecord
  belongs_to :user, optional: true
  has_many :commit_attempts
  has_many :policy_checks
  has_many :rules_checks

  alias_attribute :has_lint_desktop, :has_gatrix_desktop
  alias_attribute :has_lint_connect, :has_gatrix_connect

  self.inheritance_column = :_type_disabled

end
