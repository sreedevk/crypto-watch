class UserSubscriptionAddition < ActiveRecord::Migration[5.1]
  def change
    add_reference :currencies, :users
  end
end
