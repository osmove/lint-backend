class Plan < ApplicationRecord
  has_many :users

  is_impressionable


  def to_s
    self.name
  end
  
end
