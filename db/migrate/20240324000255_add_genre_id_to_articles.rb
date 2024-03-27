class AddGenreIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :genre_id, :integer
  end
end
