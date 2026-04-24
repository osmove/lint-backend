class Document < ApplicationRecord
  belongs_to :repository
  belongs_to :document, optional: true
  # has_many :changes, :dependent => :destroy

  # validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  # validates :path, presence: true, uniqueness: { case_sensitive: false }
  validates :path, presence: true

  # validates :status, presence: true
  #
  # def path
  #   @path ||= '/'
  # end

  extend FriendlyId

  friendly_id :name, use: :slugged

  self.inheritance_column = :_type_disabled
end
