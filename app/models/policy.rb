class Policy < ApplicationRecord
  has_many :policy_rules, dependent: :destroy
  has_many :policy_checks, dependent: :destroy

  has_many :rules, through: :policy_rules

  has_many :repositories
  belongs_to :user, optional: true

  validates :name, presence: true

  accepts_nested_attributes_for :policy_rules, allow_destroy: true, reject_if: proc { |att| att[:rule_id].blank? }
end
