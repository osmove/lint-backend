class RepositoryAccess < ApplicationRecord
  belongs_to :user
  belongs_to :repository

  # validates_uniqueness_of :user_id, :scope => :repository_id
  validates :repository_id, uniqueness: { scope: :user_id }
end
