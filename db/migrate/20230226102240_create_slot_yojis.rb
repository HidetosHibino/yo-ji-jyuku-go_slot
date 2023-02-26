class CreateSlotYojis < ActiveRecord::Migration[5.2]
  def change
    create_table :slot_yojis do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :first_kanji, foreign_key: { to_table: :kanjis }
      t.belongs_to :second_kanji, foreign_key: { to_table: :kanjis }
      t.belongs_to :third_kanji, foreign_key: { to_table: :kanjis }
      t.belongs_to :fourth_kanji, foreign_key: { to_table: :kanjis }
      t.timestamps
    end
  end
end
