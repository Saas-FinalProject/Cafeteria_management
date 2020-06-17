class AddNameToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :name, :string
  end
end
