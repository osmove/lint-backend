class Encryption < ApplicationRecord
  belongs_to :document
  belongs_to :repository
  belongs_to :user
  is_impressionable
end
