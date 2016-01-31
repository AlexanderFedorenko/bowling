class Frame < ActiveRecord::Base
  belongs_to :game
  has_many :throws

  def update_score
    self.score = self.score + self.throws.last.pins

    if self.throws[0].pins == 10
      self.throws[0].update_column(:strike, true)
      close_frame
    end

    if self.throws.count > 1 && (self.throws[0].pins + self.throws[1].pins) == 10
      self.throws[1].update_column(:spare, true)
    end

    if self.throws.count > 1
      close_frame
    end

    self.save

    self.game.update_score
  end

  def close_frame
    self.closed = true
    Frame.create({ game_id: self.game_id })
  end

  def decorated_pins(throw)
    if self.throws[throw].present?
      self.throws[throw].decorate
    end
  end
end
