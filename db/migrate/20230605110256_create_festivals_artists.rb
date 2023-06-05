class CreateFestivalsArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :festivals_artists do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :festival, null: false, foreign_key: true

      t.timestamps
    end
  end
end
