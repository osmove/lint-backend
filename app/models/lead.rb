class Lead < ApplicationRecord
  has_many :messages, dependent: :destroy
end
