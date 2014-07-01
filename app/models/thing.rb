class Thing < ActiveRecord::Base
  belongs_to :user

  after_create :set_when

  def self.today
    where(finished: false).where('date < ?', Date.today.tomorrow)
  end

  def self.unfinished
    where(finished: false)
  end

  def self.finished
    where(finished: true)
  end

  def set_when
    self.update(date: Date.today)
  end
end
