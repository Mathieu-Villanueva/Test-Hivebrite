class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.string :description

      t.timestamps
    end
  end
end
