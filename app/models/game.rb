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
    self.frames.each_with_index { |frame, index|

      next if frame.throws.count == 0

      frame.score = 0

      frame.throws.each { |throw|
        frame.score += throw.pins
      }

      if frame.throws[1].present? and frame.throws[1].spare?
        if self.frames[index + 1].present? and self.frames[index + 1].throws[0].present?
          frame.score += self.frames[index + 1].throws[0].pins
        end
      end

      # If first throw is strike
      # then add 2 throws from next frame to the score
      if frame.throws[0].strike?

        # If there is the first throw
        # then count its pins
        if self.frames[index + 1].present? and self.frames[index + 1].throws[0].present?
          frame.score += self.frames[index + 1].throws[0].pins

          # If first throw is strike
          # then go straight to the next frame
          if self.frames[index + 1].throws[0].strike?
            if self.frames[index + 2].present? and self.frames[index + 2].throws[0].present?
              frame.score += self.frames[index + 2].throws[0].pins
            end
          else
            if self.frames[index + 1].throws[1].present?
              frame.score += self.frames[index + 1].throws[1].pins
            end
          end
        end

      end

      # Close frame (and game) on strike or throws limit conditions
      unless frame.closed
        # Last frame has special conditions
        if index == 9
          if frame.throws[1].present?
            unless frame.throws[1].strike? or frame.throws[1].spare?
              frame.closed = true
              self.closed = true
            end
          end

          if frame.throws[2].present?
            frame.closed = true
            self.closed = true
          end
        else

          if frame.throws[0].strike? or frame.throws.count == 2
            frame.closed = true
            Frame.create({ game_id: self.id })
          end
        end
      end

      if index > 0
        frame.score += self.frames[index - 1].score
      end

      frame.save

      self.score = frame.score
    }

    self.save

  end
end
