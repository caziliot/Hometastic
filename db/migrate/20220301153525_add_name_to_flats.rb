class AddNameToFlats < ActiveRecord::Migration[6.1]
  def change
    add_column :flats, :name, :string
  end
end
