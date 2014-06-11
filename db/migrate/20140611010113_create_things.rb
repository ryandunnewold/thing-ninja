class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.references :user, index: true    
      
      t.datetime :finished
      t.datetime :finished_at
      
      t.integer :priority
      t.string :description

      t.timestamps
    end

    add_index :things, :priority, unique: true
  end
end
