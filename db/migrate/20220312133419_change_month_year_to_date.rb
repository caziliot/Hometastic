class ChangeMonthYearToDate < ActiveRecord::Migration[6.1]
  def change
    change_column :available_months, :month_year, "date USING CAST(month_year AS date)"
  end
end
