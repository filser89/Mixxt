class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.integer :share_count, null: false, default: 1

      t.timestamps
    end
  end
end
