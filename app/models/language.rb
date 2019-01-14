class Language < ApplicationRecord

  is_impressionable

  def to_s
    self.name
  end
  has_many :rule_checks
  has_many :frameworks
  has_many :platforms

end
