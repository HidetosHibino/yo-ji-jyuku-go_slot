class AddSoundMeaningToSlotYojis < ActiveRecord::Migration[5.2]
  def change
    add_column :slot_yojis, :sound, :string
    add_column :slot_yojis, :meaning, :string
  end
end
