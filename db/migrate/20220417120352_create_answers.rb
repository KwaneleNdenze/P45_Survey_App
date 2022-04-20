class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :answer
      t.string :answer_first_option
      t.string :answer_second_option
      t.string :answer_third_option
      t.string :answer_fourth_option
      t.string :answer_fifth_option
      t.references :question, foreign_key: true
      t.timestamps
    end
  end
end
