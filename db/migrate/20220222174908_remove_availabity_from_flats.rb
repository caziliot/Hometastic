class RemoveAvailabityFromFlats < ActiveRecord::Migration[6.1]
  def change
    remove_column :flats, :availabity
  end
end
