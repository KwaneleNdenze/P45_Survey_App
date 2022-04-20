class AddUserIdToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :user_id, :integer
    add_index :surveys, :user_id
  end
end
