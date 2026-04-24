class PolicyRuleOption < ApplicationRecord
  belongs_to :policy_rule, optional: true, touch: true
  belongs_to :rule_option, optional: true

  has_many :policy_rule_option_options, dependent: :destroy
  accepts_nested_attributes_for :policy_rule_option_options, allow_destroy: true

  has_many :rule_option_options, through: :policy_rule_option_options

  #   before_validation :stringify_value, on: [ :create, :update ]
  #
  # private
  #   def stringify_value
  #
  #     # self.value = "toto"
  #     # if self.value.kind_of?(Array)
  #     #   self.value = self.value.reject { |c| c.empty? }.join(",")
  #     # end
  #   end

  def short_description
    max = 80
    description.length > max ? "#{description[0...max]}..." : description
  end
end
