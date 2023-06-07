class AddImageToFestival < ActiveRecord::Migration[7.0]
  def change
    add_column :festivals, :image, :string
  end
end
