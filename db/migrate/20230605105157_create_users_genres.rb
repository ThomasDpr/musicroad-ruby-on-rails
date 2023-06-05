class CreateUsersGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :users_genres do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
