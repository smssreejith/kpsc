class AddColumnRoleToExamRank < ActiveRecord::Migration
  def change
    add_column :exam_ranks, :role, :string
  end
end
