class Change < ApplicationRecord
  belongs_to :document
  belongs_to :commit
end
