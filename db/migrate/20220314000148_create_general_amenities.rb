class CreateGeneralAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :general_amenities do |t|
      t.string :title
      t.string :icon_class

      t.timestamps
    end
  end
end
