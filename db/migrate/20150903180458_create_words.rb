class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :category
      t.boolean :ignore, :default => false

      t.timestamps null: false
    end
  end
end
