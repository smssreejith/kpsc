class CreateExamRanks < ActiveRecord::Migration
  def change
    create_table :exam_ranks do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :total
      t.integer :correct
      t.integer :wrong
      t.decimal :mark, :precision => 5, :scale => 2

      t.timestamps null: false
    end
  end
end
