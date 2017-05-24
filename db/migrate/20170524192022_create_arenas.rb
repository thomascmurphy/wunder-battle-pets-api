class CreateArenas < ActiveRecord::Migration[5.1]
  def change
    create_table :arenas do |t|
      t.string :battle_type, index: true

      t.timestamps
    end
  end
end
