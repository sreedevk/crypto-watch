class CreateCurrencyHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_histories do |t|
      t.belongs_to :currency
      t.float :current_price
      t.integer :rank
      t.float :circulating_supply
      t.float :total_supply
      t.float :max_supply
      t.float :price_eur
      t.float :price_inr
      t.float :volume_24h_usd
      t.float :volume_24h_inr
      t.float :volume_24h_eur
      t.float :perc_change_1h_usd
      t.float :perc_change_24h_usd
      t.float :perc_change_7d_usd
      t.float :perc_change_1h_inr
      t.float :perc_change_24h_inr
      t.float :perc_change_7d_inr
      t.float :perc_change_1h_eur
      t.float :perc_change_24h_eur
      t.float :perc_change_7d_eur
      t.float :market_cap_usd
      t.float :market_cap_inr
      t.float :market_cap_eur
      t.datetime :update_time
      t.timestamps
    end
  end
end
