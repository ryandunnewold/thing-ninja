class List < ActiveRecord::Base
  belongs_to :user
  has_many :things, dependent: :destroy
end