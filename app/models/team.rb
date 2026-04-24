class Team < ApplicationRecord
  belongs_to :parent, class_name: 'Team', foreign_key: 'team_id', optional: true
  has_many :children, class_name: 'Team'
  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  validates :name, presence: true

  before_create :add_creator_to_members
  def add_creator_to_members
    membership = Membership.create({ user: user, role: 'admin' })
    memberships.push(membership)
  end
end
