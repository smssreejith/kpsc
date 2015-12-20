class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :exam_id
      t.string :q_num
      t.string :one
      t.string :two
      t.string :three
      t.string :four
      
      t.timestamps null: false
    end
  end
end
