class CreateGuestUsers < ActiveRecord::Migration
  def change
    create_table :guest_users do |t|

      t.timestamps null: false
    end
  end
end
