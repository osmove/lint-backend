class Plan < ApplicationRecord
  has_many :users



  def to_s
    self.name
  end
  
end
