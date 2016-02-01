class Throw < ActiveRecord::Base
  belongs_to :frame

  validates :pins, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  before_save :set_strike_and_spare_flags
  after_save :update_frames_score

  def set_strike_and_spare_flags
    if self.pins == 10
      self.strike = true
    end

    if self.frame.throws.count == 1 and (self.frame.throws[0].pins + self.pins) == 10
      self.strike = false
      self.spare = true
    end
  end

  def update_frames_score
    self.frame.game.update_score
  end

  def strike?
    self.strike
  end

  def spare?
    self.spare
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
