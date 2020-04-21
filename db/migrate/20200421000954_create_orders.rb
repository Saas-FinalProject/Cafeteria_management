class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.datetime :delivered_at
      t.bigint :user_id
    end
  end
end
