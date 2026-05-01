class Project < ApplicationRecord
  belongs_to :user
  has_many :repositories, dependent: :nullify

  before_validation :set_slug, if: -> { slug.blank? && name.present? }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :status, presence: true

  def to_s
    name
  end

private

  def set_slug
    self.slug = name.parameterize
  end
end
