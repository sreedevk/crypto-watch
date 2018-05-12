class CreateNewsProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :news_providers do |t|
      t.string :name
      t.string :source
      t.string :update_frequency
      t.integer :update_period
      t.text :description
      t.timestamps
    end
  end
end
