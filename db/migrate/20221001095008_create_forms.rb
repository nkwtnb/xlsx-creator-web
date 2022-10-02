class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.numeric :seq
      t.string :name
      t.string :description
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
