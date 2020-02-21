class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :description
      t.string :liked_because
      t.integer :list_rank
      t.integer :user_id
    end
  end
end
