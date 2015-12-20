class UserAnswer < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :exam, dependent: :destroy
end
