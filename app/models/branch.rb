class Branch < ApplicationRecord
  belongs_to :repository
  is_impressionable
end
