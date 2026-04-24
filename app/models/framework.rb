class Framework < ApplicationRecord

  def to_s
    self.name
  end

  belongs_to :language, optional: true
  has_many :platforms

end
