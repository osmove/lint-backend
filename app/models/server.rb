class Server < ApplicationRecord
  belongs_to :user

  is_impressionable


  def to_s
    self.name
  end
  
end
