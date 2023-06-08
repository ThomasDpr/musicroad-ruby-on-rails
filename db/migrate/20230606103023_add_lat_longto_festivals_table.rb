class AddLatLongtoFestivalsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :latitude, :float
    add_column :festivals, :longitude, :float
    add_column :festivals, :min_price, :float
    add_column :festivals, :max_price, :float
    add_column :festivals, :start_date, :date
  end
end
