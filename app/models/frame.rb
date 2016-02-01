class Frame < ActiveRecord::Base
  belongs_to :game
  has_many :throws

  def decorated_pins(throw)
    if self.throws[throw].present?
      self.throws[throw].decorate
    end
  end
end
