class CreateUserReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reactions do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :slot_yoji, foreign_key: true
      t.string :body, null: false

      t.timestamps
    end
  end
end
