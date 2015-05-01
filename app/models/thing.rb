class Thing < ActiveRecord::Base
  belongs_to :list

  def self.today
    where(finished: false).where('date < ?', Date.today.tomorrow)
  end

  def self.procrastinated
    where(finished: false).where('date > ?', Date.today)
  end

  def self.unfinished
    where(finished: false)
  end

  def self.finished
    where(finished: true)
  end

  def self.finished_today
    where(finished: true).where('finished_at > ? AND finished_at < ?', Date.today, Date.today.tomorrow)
  end
end
