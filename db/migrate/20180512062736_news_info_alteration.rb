class NewsInfoAlteration < ActiveRecord::Migration[5.1]
  def change
    add_column :news_infos, :content, :text
  end
end
