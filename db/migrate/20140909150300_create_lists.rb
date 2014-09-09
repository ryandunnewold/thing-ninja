class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :user, index: true

      t.integer :priority
      t.string :title

      t.timestamps
    end
  end
end
