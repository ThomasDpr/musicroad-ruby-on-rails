class AddEndDateFestivalAndUrlLink < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :end_date, :date
    add_column :festivals, :url, :string
  end
end
