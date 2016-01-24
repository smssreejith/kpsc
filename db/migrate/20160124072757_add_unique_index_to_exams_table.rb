class AddUniqueIndexToExamsTable < ActiveRecord::Migration
  def change
    add_index :exams, [:exam_type, :code], :unique => true
  end
end
