class Language < ApplicationRecord
  def to_s
    name
  end
  has_many :rule_checks
  has_many :frameworks
  has_many :platforms
end
