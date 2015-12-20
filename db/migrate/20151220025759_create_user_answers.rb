class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :exam_id
      t.string :booklet
      t.integer :q_num
      t.string :answer

      t.timestamps null: false
    end
  end
end
