class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :exam_type
      t.string :code
      t.string :name
      t.string :date

      t.timestamps null: false
    end
  end
end
