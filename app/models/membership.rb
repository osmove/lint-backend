class Membership < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :organization, class_name: 'User', optional: true
  belongs_to :team, optional: true
end
