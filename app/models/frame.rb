class Frame < ActiveRecord::Base
  belongs_to :game
  has_many :throws

  def update_score
    self.score = self.score + self.throws.last.pins

    if self.throws.count > 1 || self.throws.last.pins == 10
      self.closed = true
      Frame.create({ game_id: self.game_id })
    end

    self.save

    self.game.update_score
  end
end
