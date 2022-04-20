class ChangeQuestionsToQuestion < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :questions, :question
  end
end
