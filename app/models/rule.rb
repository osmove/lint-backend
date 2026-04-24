class Rule < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :framework, optional: true
  belongs_to :platform, optional: true

  belongs_to :linter, optional: true

  has_many :policy_rules, inverse_of: :rule, dependent: :destroy
  has_many :policies, through: :policy_rules

  has_many :rule_options, dependent: :destroy
  has_many :rule_checks, dependent: :destroy

  accepts_nested_attributes_for :rule_options, allow_destroy: true, reject_if: :all_blank

  has_many :rule_option_options, through: :rule_options
  accepts_nested_attributes_for :rule_option_options, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :rule_option_options

  has_many :children, class_name: 'Rule', foreign_key: 'parent_id', inverse_of: :parent, dependent: :nullify
  belongs_to :parent, class_name: 'Rule', inverse_of: :children, optional: true

  self.inheritance_column = :_type_disabled

  validate :check_rule_is_unique, on: :create

  def check_rule_is_unique
    return unless Rule.where(name: name).any?

    errors.add(:base, :duplicate)
    false
  end

  def to_s
    name
  end

  def short_description
    max = 80
    description.length > max ? "#{description[0...max]}..." : description
  end
end
