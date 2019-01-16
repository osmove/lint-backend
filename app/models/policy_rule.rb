class PolicyRule < ApplicationRecord
  belongs_to :rule, optional: true
  belongs_to :policy, optional: true, touch: true
  belongs_to :linter, optional: true

  has_many :policy_rule_options, :dependent => :destroy
  accepts_nested_attributes_for :policy_rule_options, allow_destroy: true

  has_many :policy_rule_option_options, through: :policy_rule_options

  has_many :rule_option, through: :policy_rule_options

  self.inheritance_column = :_type_disabled



  STATUS_OPTIONS = [['Off', 'off'], ['Warn', 'warn'], ['Error', 'error']]

  after_initialize do
    self.status ||= "off"
  end

  def short_description
    max = 80
    self.description.length > max ? "#{self.description[0...max]}..." : self.description
  end

  before_save :copy_info_from_rule
  def copy_info_from_rule
    if self.rule.present?
      self.name = self.rule.name
      self.slug = self.rule.slug
      self.type = self.rule.type
      self.description = self.rule.description
      self.fixable = self.rule.fixable
      self.linter = self.rule.linter
    end
  end

end
