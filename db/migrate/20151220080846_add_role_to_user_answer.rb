class AddRoleToUserAnswer < ActiveRecord::Migration
  def change
    add_column :user_answers, :role, :string
  end
end
