class RuleOption < ApplicationRecord
  belongs_to :rule
  has_many :policy_rule_options, dependent: :destroy
  has_many :rule_option_options, dependent: :destroy

  accepts_nested_attributes_for :policy_rule_options, allow_destroy: true, reject_if: :all_blank

  accepts_nested_attributes_for :rule_option_options, allow_destroy: true, reject_if: :all_blank

  VALUE_TYPE_OPTIONS = [%w[Boolean boolean], %w[Integer integer], %w[String string],
                        %w[Array-Single array-single], %w[Array-Multiple array-multiple]]

  validate :check_rule_option_is_unique, on: :create

  def check_rule_option_is_unique
    return unless RuleOption.where(slug: slug, rule: rule).any?

    errors.add(:base, :duplicate)
    false
  end

  def short_description
    max = 80
    description.length > max ? "#{description[0...max]}..." : description
  end
end
