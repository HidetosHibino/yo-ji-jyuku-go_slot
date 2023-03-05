class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :bookmarkable, polymorphic: true

      t.timestamps
    end
  end
end
