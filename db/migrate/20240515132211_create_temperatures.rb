class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|

      t.timestamps
      t.string :temperatures_name
    end
  end
end
