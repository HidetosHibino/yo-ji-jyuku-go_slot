class AddMeaningToBasicYojis < ActiveRecord::Migration[5.2]
  def change
    add_column :basic_yojis, :meaning, :string
  end
end
