class AddSoundToBaseYoji < ActiveRecord::Migration[5.2]
  def change
    add_column :basic_yojis, :sound, :string
  end
end
