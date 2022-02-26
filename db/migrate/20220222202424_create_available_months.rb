class CreateAvailableMonths < ActiveRecord::Migration[6.1]
  def change
    create_table :available_months do |t|
      t.string :month_year
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
