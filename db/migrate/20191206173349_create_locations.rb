class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :title
      t.float :lat
      t.float :lng
      t.references :keyword, foreign_key: true

      t.timestamps
    end
  end
end
