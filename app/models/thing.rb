class Thing < ActiveRecord::Base
  belongs_to :user

  def self.unfinished
    where(finished: false)
  end

  def self.finished
    where(finished: true)
  end
end
