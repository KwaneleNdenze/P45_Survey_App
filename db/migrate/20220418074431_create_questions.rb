class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :questions
      t.string :question_type
      t.string :question_first_option
      t.string :question_second_option
      t.string :question_third_option
      t.string :question_fourth_option
      t.string :question_fifth_option
      t.references :survey, index: true, foreign_key: true
      t.timestamps
    end
  end
end
