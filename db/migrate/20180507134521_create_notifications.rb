class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :title
      t.string :content
      t.string :icon_name
      t.string :type
      t.boolean :read
      t.timestamps
    end
  end
end
