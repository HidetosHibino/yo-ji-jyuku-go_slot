class CreateSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :samples do |t|
      t.references :sampleable, polymorphic: true
      t.string :body
      t.belongs_to :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
