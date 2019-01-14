class Command < ApplicationRecord
  has_many :buildpacks, :dependent => :destroy
  has_many :buttons, :dependent => :destroy
  belongs_to :repository
  belongs_to :user
  is_impressionable
end
