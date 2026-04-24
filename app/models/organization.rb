class Organization < ApplicationRecord
  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  validates :name, presence: true

  def to_s
    name
  end

  before_create :add_creator_to_members
  def add_creator_to_members
    membership = Membership.create({ user: user, role: 'admin' })
    memberships.push(membership)
  end
end
