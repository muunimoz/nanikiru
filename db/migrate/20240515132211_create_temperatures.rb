class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|

      t.timestamps
      t.string :temperature_name
    end
  end
end
