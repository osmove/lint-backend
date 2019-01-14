class RuleOptionOption < ApplicationRecord
  belongs_to :rule_option
  has_many :policy_rule_option_options, inverse_of: :rule_option_option, dependent: :delete_all
  accepts_nested_attributes_for :policy_rule_option_options, allow_destroy: true, :reject_if => :all_blank



  def short_description
    max = 80
    self.description.length > max ? "#{self.description[0...max]}..." : self.description
  end

  validate :check_rule_option_option_is_unique, :on => :create

  def check_rule_option_option_is_unique
    if RuleOptionOption.where(value: self.value, rule_option_id: self.rule_option).any?
      errors.add(:base, :duplicate)
      return false
    end
  end

end
