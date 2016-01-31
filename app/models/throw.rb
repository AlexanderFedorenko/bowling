class Throw < ActiveRecord::Base
  belongs_to :frame

  validates :pins, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  after_save :update_frame_score

  def update_frame_score
    self.frame.update_score
  end

  def decorate
    if self.strike?
      'X'
    elsif self.spare?
      '/'
    else
      self.pins
    end
  end
end
