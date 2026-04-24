class Plan < ApplicationRecord
  has_many :users, dependent: :nullify

  def to_s
    name
  end
end
