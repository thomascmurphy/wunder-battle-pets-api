class CreateContests < ActiveRecord::Migration[5.1]
  def change
    create_table :contests do |t|
      t.string :pet_1_id, index: true
      t.string :pet_2_id, index: true
      t.string :winner_id
      t.references :discipline, foreign_key: true

      t.timestamps
    end
  end
end
