class Button < ApplicationRecord
  belongs_to :command
  belongs_to :repository
  belongs_to :user
  is_impressionable
end
