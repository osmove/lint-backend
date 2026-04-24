class PolicyRule < ApplicationRecord
  belongs_to :rule, optional: true
  belongs_to :policy, optional: true, touch: true
  belongs_to :linter, optional: true

  has_many :policy_rule_options, dependent: :destroy
  accepts_nested_attributes_for :policy_rule_options, allow_destroy: true

  has_many :policy_rule_option_options, through: :policy_rule_options

  has_many :rule_option, through: :policy_rule_options

  self.inheritance_column = :_type_disabled

  STATUS_OPTIONS = [%w[Off off], %w[Warn warn], %w[Error error]].freeze

  after_initialize do
    self.status ||= 'off'
  end

  def short_description
    max = 80
    description.length > max ? "#{description[0...max]}..." : description
  end

  before_save :copy_info_from_rule
  def copy_info_from_rule
    return if rule.blank?

    self.name = rule.name
    self.slug = rule.slug
    self.type = rule.type
    self.description = rule.description
    self.fixable = rule.fixable
    self.linter = rule.linter
  end
end
