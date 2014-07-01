class AddTodayToThings < ActiveRecord::Migration
  def change
    add_column :things, :date, :date
  end
end
