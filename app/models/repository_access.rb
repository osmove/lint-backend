class RepositoryAccess < ApplicationRecord
  belongs_to :user
  belongs_to :repository


  # validates_uniqueness_of :user_id, :scope => :repository_id
  validates_uniqueness_of :repository_id, :scope => :user_id

end
