class CreateAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :amenities do |t|
      t.string :title
      t.string :icon_class
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
