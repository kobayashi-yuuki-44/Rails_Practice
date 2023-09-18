class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
