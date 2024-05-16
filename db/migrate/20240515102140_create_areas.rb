class CreateAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :areas do |t|

      t.string :area_name
      t.timestamps
      
    end
  end
end
