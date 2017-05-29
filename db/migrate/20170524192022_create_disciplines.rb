class CreateDisciplines < ActiveRecord::Migration[5.1]
  def change
    create_table :disciplines do |t|
      t.string :name, index: true
      t.text :description

      t.timestamps
    end
  end
end
