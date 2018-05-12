class AddColumnCategoriesToNewsInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :news_infos, :categories, :text
  end
end
