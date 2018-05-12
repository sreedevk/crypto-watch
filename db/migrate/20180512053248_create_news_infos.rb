class CreateNewsInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :news_infos do |t|
      t.string :title
      t.belongs_to :news_provider
      t.string :link 
      t.string :media_content
      t.string :enclosure
      t.datetime :published_date
      t.timestamps 
    end
  end
end
