class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.boolean :admin, default: false
      t.string :email, null: false
      t.index :email, unique: true

      t.timestamps
    end
  end
end
