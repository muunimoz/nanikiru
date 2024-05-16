class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      
      t.integer :user_id
      t.integer :area_id
      t.integer :temperature_id
      t.string :comments
      
    end
  end
end
