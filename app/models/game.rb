class Game < ActiveRecord::Base
  has_many :frames

  after_create :generate_frame

  def generate_frame
    Frame.create({ game_id: self.id })
  end

  def current_frame
    self.frames.find { |frame|
      !frame.closed
    }
  end

  def update_score
    self.score = 0
    self.frames.each { |frame|
      self.score = self.score + frame.score
    }
    self.save
  end
end
