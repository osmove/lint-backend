class Language < ApplicationRecord
  def to_s
    name
  end
  has_many :rule_checks, dependent: :destroy
  has_many :frameworks, dependent: :destroy
  has_many :platforms, dependent: :destroy
end
