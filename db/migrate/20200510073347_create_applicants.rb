class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :option
      t.string :email
      t.text :address
      t.bigint :phone
    end
  end
end
