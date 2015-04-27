class List < ActiveRecord::Base
  belongs_to :user
  has_many :things

  before_destroy :delete_things

  def delete_things
    self.things.where(finished: false).destroy_all
  end
end
