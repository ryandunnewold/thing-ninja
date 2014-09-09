class UpdateThings < ActiveRecord::Migration
  def change
    remove_column :things, :user_id
    add_column :things, :list_id, :integer
  end
end
