class CreateFlats < ActiveRecord::Migration[6.1]
  def change
    create_table :flats do |t|
      t.string :address
      t.integer :price
      t.text :description
      t.string :city
      t.string :availabity
      t.string :photos, array: true, default: []
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
