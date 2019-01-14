class Change < ApplicationRecord
  belongs_to :document
  belongs_to :commit
  is_impressionable
end
