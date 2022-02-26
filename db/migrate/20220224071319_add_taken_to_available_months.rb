class AddTakenToAvailableMonths < ActiveRecord::Migration[6.1]
  def change
    add_column :available_months, :taken, :boolean, default: false
  end
end
