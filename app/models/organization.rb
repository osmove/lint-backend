class Organization < ApplicationRecord
  belongs_to :user
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, presence: true

  is_impressionable


  def to_s
    self.name
  end


  before_create :add_creator_to_members
  def add_creator_to_members
    membership = Membership.create({user: self.user, role: 'admin'})
    self.memberships.push(membership)
  end


end
