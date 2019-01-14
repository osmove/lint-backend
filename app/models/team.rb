class Team < ApplicationRecord
  belongs_to :parent, class_name: 'Team', optional: true
  has_many :children, class_name: 'Team', foreign_key: "parent_id"
  belongs_to :user
  has_many :memberships
  has_many :users, :through => :memberships
  validates :name, presence: true


  before_create :add_creator_to_members
  def add_creator_to_members
    membership = Membership.create({user: self.user, role: 'admin'})
    self.memberships.push(membership)
  end

end
