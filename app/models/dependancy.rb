class Dependancy < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  is_impressionable
end
