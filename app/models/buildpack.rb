class Buildpack < ApplicationRecord
  belongs_to :command
  belongs_to :repository
  belongs_to :user
end
