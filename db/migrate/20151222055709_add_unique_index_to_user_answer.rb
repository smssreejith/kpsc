class AddUniqueIndexToUserAnswer < ActiveRecord::Migration
  def change
    add_index :user_answers, [:role, :user_id, :exam_id, :q_num], :unique => true
  end
end
