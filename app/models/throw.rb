class Throw < ActiveRecord::Base
  belongs_to :frame

  validates :pins, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  validate :throws_pins_sum_is_less_than_or_equal_to_ten

  before_save :set_strike_and_spare_flags
  after_save :update_frames_score

  def throws_pins_sum_is_less_than_or_equal_to_ten
    if self.frame.game.frames[9].present?
      # TODO Validation rule for last frame
    elsif self.frame.throws.count > 0 and (self.frame.throws[0].pins + self.pins > 10)
      errors.add(:pins, 'Total pins number in a frame must be 10')
    end
  end

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
