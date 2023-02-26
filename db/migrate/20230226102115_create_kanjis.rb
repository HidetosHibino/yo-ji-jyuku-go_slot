class CreateKanjis < ActiveRecord::Migration[5.2]
  def change
    create_table :kanjis do |t|
      t.string :letter, null: false
      t.timestamps
    end
  end
end
