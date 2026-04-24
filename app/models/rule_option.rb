class RuleOption < ApplicationRecord
  belongs_to :rule
  has_many :policy_rule_options, :dependent => :destroy
  has_many :rule_option_options, :dependent => :destroy

  accepts_nested_attributes_for :policy_rule_options, allow_destroy: true, :reject_if => :all_blank

  accepts_nested_attributes_for :rule_option_options, allow_destroy: true, :reject_if => :all_blank

  VALUE_TYPE_OPTIONS = [['Boolean', 'boolean'], ['Integer', 'integer'], ['String', 'string'], 
                        ['Array-Single','array-single'], ['Array-Multiple','array-multiple']]

  validate :check_rule_option_is_unique, :on => :create

  def check_rule_option_is_unique
    if RuleOption.where(slug: self.slug, rule: self.rule).any?
      errors.add(:base, :duplicate)
      return false
    end
  end

  def short_description
    max = 80
    self.description.length > max ? "#{self.description[0...max]}..." : self.description
  end


end
