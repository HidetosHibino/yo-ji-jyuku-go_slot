class AddNameToBasicYoji < ActiveRecord::Migration[5.2]
  def change
    add_column :basic_yojis, :name, :string, null: false, index: { unique: true }
  end
end
