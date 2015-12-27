class AddUniqueIndexToExamRank < ActiveRecord::Migration
  def change
    add_index :exam_ranks, [:role, :user_id, :exam_id], :unique => true
  end
end
