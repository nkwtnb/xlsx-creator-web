class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.references :user, foreign_key: true, null: false
      t.numeric :seq, null: false
      t.string :original_name, null: false
      t.string :file_name, null: false
      t.string :description
      t.timestamps
    end
  end
end
