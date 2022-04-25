class AddOrderToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :order, :integer, default: 0
  end
end
