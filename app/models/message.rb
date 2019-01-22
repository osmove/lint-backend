class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lead, optional: true
end
